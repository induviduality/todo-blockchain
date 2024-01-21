chmod -R 0755 ./crypto-config
# Delete existing artifacts
rm -rf ./crypto-config
rm genesis.block todochannel.tx
rm -rf ../../channel-artifacts/*

# Step 1:
# Generate crypto artifacts for orgs
cryptogen generate --config=./crypto-config.yaml --output=./crypto-config/

# Step 2:
# System Channel
SYS_CHANNEL="sys-channel"

# channel name defaults to "todochannel"
CHANNEL_NAME="todochannel"

# Generate System Genesis Block
configtxgen -profile OrdererGenesis -configPath . -channelID $SYS_CHANNEL -outputBlock ./genesis.block

# Generate channel configuration block
configtxgen -profile BasicChannel -configPath . -outputCreateChannelTx ./todochannel.tx -channelID $CHANNEL_NAME

# Step 3:
# echo "#######    Generating anchor peer update for ToDoOrgMSP    ##########"

# # The -outputAnchorPeersUpdate output flag has been deprecated. To set anchor peers on the channel, 
# # use configtxlator to update the channel configuration.
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./ToDoOrgMSPanchors.tx -channelID $CHANNEL_NAME -asOrg ToDoOrgMSP

