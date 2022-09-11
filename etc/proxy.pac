function FindProxyForURL(url, host)
{
	if(host.match(/[.]i2p$/))
		return 'PROXY 127.0.0.1:4444';
	return 'DIRECT';
}
