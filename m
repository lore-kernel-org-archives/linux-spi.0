From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC] spi: orion.c: Add direct write mode
Date: Thu, 14 Jan 2016 10:52:11 +0000
Message-ID: <20160114105211.GQ6588@sirena.org.uk>
References: <1452589339-21402-1-git-send-email-sr@denx.de>
 <20160112101358.GY6588@sirena.org.uk>
 <569747E4.2080402@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B1+FeH9/zg1Fgdnk"
Cc: Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <569747E4.2080402-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--B1+FeH9/zg1Fgdnk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 14, 2016 at 08:01:56AM +0100, Stefan Roese wrote:
> On 12.01.2016 11:13, Mark Brown wrote:

> >>+	/* Use SPI direct write mode if such an address is provided via DT */
> >>+	orion_spi = spi_master_get_devdata(spi->master);
> >>+	direct_addr = orion_spi->slave_direct_addr[spi->chip_select];
> >>+	if (direct_addr && xfer->tx_buf) {
> >>+		/* Deassert CS between the SPI transfers */
> >>+		writel(0x00010000, spi_reg(orion_spi,
> >>+					   SPI_DIRECT_WRITE_CONFIG_REG));

> >This is badly broken, we should be asserting /CS over the entire message
> >unless the individual transfer says otherwise.  I'm surprised this
> >works.

> It works, at least on the FPGA that I'm programming the bitstream into
> right now. The reason for deasserting the CS after each SPI transfer
> was, to work around potential problems with concurrent accesses to
> other SPI devices connected to the same SPI controller. Like SPI NOR
> flash devices using the "normal" indirect mode. Deasserting the CS
> seemed like the "safe" way to me here.

No, this is not remotely safe - it is going to break any device where
the driver uses more than one transfer per message.  Instead of one
operation on the bus with /CS held over the entire operation the device
will see multiple operations.

> >and what if the transfer is bidirectional?  It looks like we
> >can only do this for transmit only transfers.

> This patch only adds support for the direct write mode. As the main
> purpose is to speed up the SPI TX throughput for FPGA bitstream
> programming. It could be extended to support also the direct read
> mode. But this would need more configuration options, like the
> number of address-bytes to transfer in each read access. Not sure
> how this should interact with the SPI flash driver from the MTD
> subsystem.

> I would prefer to not adding this direct read mode just yet. It
> can be added later, if really needed.

I can't see anything which will prevent trying to use direct write in
combination with a read which I'd not expect to work.

--B1+FeH9/zg1Fgdnk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWl33aAAoJECTWi3JdVIfQ8g0H/A0MY60ZkigCmniV/XfxpqXT
htuqUO93o4ipsYUCDhyZcf2CN9BBehFRVzS56JQqllJxIY4ee/7R1MHDpShjBPll
Fvf5vNYXBwPzHvBUjksc3r8VlzxfzgWwgknJTKRfaHGUJsY6GxzTJJiNqDIwGwkt
9Y0Ud0Tw0lKKHcAgCSrDULJaNKFY3lk3DyzIowJI6c/7BAioJ35CqBhDsJ9GOn3D
V1y/dbXAau/ucuJCnVyx+mP6851cr0lkRyDPLV+hzHa8Kya0z0Ul2hZcQ7mcYMxE
BdAFEqTAPQyvHWuP/KMnlwp/3uqXQl+PTD/1auIwXPYpJb+EHXdOGp6P/hyoazI=
=Gjzi
-----END PGP SIGNATURE-----

--B1+FeH9/zg1Fgdnk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
