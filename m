From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Tue, 29 Oct 2013 15:53:53 -0700
Message-ID: <20131029225353.GB11424@sirena.org.uk>
References: <F70C4469-6325-48D5-A7CA-52CC1FC404BD@sperl.org>
 <CACRpkdb6y=o4__snBs2DR1f=xW_u7KdkHg3fb7XN5e2gicBJeg@mail.gmail.com>
 <CACRpkdb7y88oq7XyVFc_0Nx4pXtaebPe7KB2yizBRJGwWLqJig@mail.gmail.com>
 <06C7F4D3-EC91-46CF-90BE-FC24D54F2389@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <06C7F4D3-EC91-46CF-90BE-FC24D54F2389-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2013 at 10:18:55PM +0100, Martin Sperl wrote:

Please fix your mailer to word wrap within paragraphs, it will greatly
improve readability of your messages.

> Finally I am also not sure how dmaengine can work when 2 DMAs are
> required working in parallel (one for RX the other for TX).  All this
> means that I have to schedule the RX DMA from the TX-DMA and vice
> versa - in addition to configuring the SPI registers via DMA and
> working arround those HW-bugs.

There's plenty of examples of this in mainline for SPI and other
subsystems, mostly this is fairly simple to implement - for example just
enable the DMAs prior to enablig the SPI controller then the SPI
controller triggerrs the actual transfers.

> But with all that said, I can do a single SPI_MESSAGE with 5 transfers
> ,  2 of which have CS_CHANGE only with DMA without any interrupts -
> besides the final interrupt to trigger the wakeup of the
> spi_message_pump thread.

How exactly does this work in concrete terms?  I'm particularly
interested in how the /CS manipluation is done.  The basic idea doesn't
sound terribly different to things a lot of devices can do with driving
the transfers from the IRQ handler (possibly hard IRQ handler) without
waking the tasklet, I'd hope we can make this work as a special case of
that.

> As for the prepare_spi_message - I was asking for something different
> than prepare_transfer_hardware (unless there is new code there in 3.12
> that already includes that - or it is in a separate tree).

You should be working against the latest development code, we're almost
at the merge window for v3.13, the v3.12 code is about 3 months old at
this point.  Also bear in mind that this is open source, you can extend
the frameworks if they don't do what you want.

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScDx3AAoJELSic+t+oim9VdgQAIox19E4CnbPxYTtEPAVUap2
jwvJGOt5tl16pkyeqhtlE/JRWweBP2g+DxsN5BjNEGsHRUYdKrJjJyJQxvGesPeF
vqwXo6T6UoE+aLzuhh0BeSMSusIqmXNY/NB7ynNrtXIKJKi2Qka6MKKoCCJddgrW
wp9s4cSUyaLSx1StqcqNSKFmQiBbaqMJPtTUD1lf8HNvzQ6qwlhA6IGJh8WEp2vH
C/AsB1lyMroYC8R/eFV6og0W5tVSazlQtMw232NzLh4rTgZWU0WsnQBEaiNiiUVk
uigf8607gngrisXqAkmWu6+ur5pWYPdDp0ymvVw2HrbkQ9JsHfh0/UODchDhRSXZ
QqFXsbSBGtnYCwvUu9LRtygaAjFxIfjxTkvOlcmuzpYL1kW7pFeZjeOCfgoBYn0u
mpyuk0p8SGriK4vbwZZqQdBO5P/AcdaqxEMw12b3ANgjtovVGdBKusFe/4PTDjZv
SnWSY6SRzR8KBziIfoa2ZKz9hPKeH6zn8P2+ngUPeEV7x1Th8tVkrLuUSmKW6Ura
E38YlksJRipUyz/g9CheN5v2+5Tw4l/4I7IfEWlVyq7Xm3vmuPFXB9EOCJmZ5u7k
Bye9WlOY/oYEw0sIxmz5K2xHvfOtWqG9dhy07nuHkE1z7MtN20wxUYVnxUcdCYtA
LUA1qrFyCPVOC08pugS7
=fsC1
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
