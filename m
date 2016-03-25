From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [LINUX PATCH 1/2] mtd: Added dummy entry in the spi_transfer
 structure.
Date: Fri, 25 Mar 2016 15:01:09 +0000
Message-ID: <20160325150109.GF2566@sirena.org.uk>
References: <1458562809-36114-1-git-send-email-lakshmis@xilinx.com>
 <20160321130734.GS2566@sirena.org.uk>
 <4FF8F58FAA9D5D4193D4E554E4352C5902C6D34C@XAP-PVEXMBX02.xlnx.xilinx.com>
 <20160322100615.GA2566@sirena.org.uk>
 <4FF8F58FAA9D5D4193D4E554E4352C5902C6DB59@XAP-PVEXMBX02.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K4TeRK2lnUi9hBXL"
Cc: Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	"Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	Jagan Teki <jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Anirudha Sarangi <anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Lakshmi Sai Krishna Potthuri
	<lakshmi.sai.krishna.potthuri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FF8F58FAA9D5D4193D4E554E4352C5902C6DB59-4lKfpRxZ5ekkx2a1wsGfbYg+Gb3gawCHQz34XiSyOiE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--K4TeRK2lnUi9hBXL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 25, 2016 at 01:41:16PM +0000, Lakshmi Sai Krishna Potthuri wrote:

As I'm fairly sure I've said before please fix your mail client to word
wrap within paragraphs at something substantially less than 80 columns.
Doing this makes your messages much easier to read and reply to.

> >This is really not what I'd expect to happen, I'd expect that these dummy
> >cycles would be in addition to the actual data (see my request for better
> >documentation...).  If they overlap with the data then what is the point in
> >specifying this?  It's more work for the host, what benefit do we get from
> >doing it over just handing it like a normal byte?

> len field in the transfer structure contains dummy bytes along with actual data
> bytes, controllers which requires dummy bytes use len field and simply Ignore
> the dummy field (contains only no of cycles)added in this patch. Controllers
> (like ZynqMP GQSPI) expects dummy in cycles won't work directly by using
> len field because host driver doesn't know that len field of a particular transfer
> includes dummy bytes or not (and also number of dummy bytes included in len
> field). In such cases driver use this dummy field to identify the number of dummy
> cycles and based on that it will send the required number of dummy cycles (which
> i did in the second patch).

This doesn't make any sense at all to me.  Why does the controller care
what the bytes being sent to and from the device mean?

--K4TeRK2lnUi9hBXL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW9VKzAAoJECTWi3JdVIfQ+MIH/1+HkvEE6Ni1KnJoU+HCfSgl
aXmOYcM7VHQ2AKBsnlXNFxkc0sPdxUsdB3pihdNK/RSzxjsUy0apliTeCal4Nr11
jUfGPFc5CYoWGgta6JZFEzQ9pOarVNyrQrc+z7IrutwehLqV9rGnf9Q9kZBJ10ii
bpCN/GT/Nlq8J6CY6SkDFuhjuqZfiueRx2xGDQfXY1Cs+L1YmLoY4Czm2eg4mPbd
H7vFjrTvcsiNb4H5OTUqvpFs4YVXMxoW37ta9TvOWKVZUiidCfzL8G4JzrIFpGwV
bnIWeqSV3vgroCWvIdXKGxy/Fau1A/JT/lf7kayH1LGR+CzkGzYg0bJ93z0HX6g=
=bEvJ
-----END PGP SIGNATURE-----

--K4TeRK2lnUi9hBXL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
