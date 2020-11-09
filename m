Return-Path: <SRS0=Zwo0=EP=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73393C4741F
	for <linux-spi@archiver.kernel.org>; Mon,  9 Nov 2020 13:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20887206ED
	for <linux-spi@archiver.kernel.org>; Mon,  9 Nov 2020 13:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604928596;
	bh=uFEtIlKezOT9TIZTKmINrxsNQ5X+2p18rkvgsgVL0L0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rylBtu1GeTlTC8wuXyvorQbQARmUy4/q6xJCtgR9BkyYf9syGXgFfp5SwdvrG5CJ6
	 ixFBi+KBKQsuCrNt450P5MtvTxYw7O1Hgl+0PlZ69IHpipQz5zUel8KSaeYIM4v0Mp
	 CJb4QBeryU22RDDbDMmj0N3EItCv/MWTPrTF9+Qk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733162AbgKIN3y (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 9 Nov 2020 08:29:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732507AbgKIN3u (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 08:29:50 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBC40206ED;
        Mon,  9 Nov 2020 13:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604928589;
        bh=uFEtIlKezOT9TIZTKmINrxsNQ5X+2p18rkvgsgVL0L0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PEG8KeoO1wg/M/IVLPzj/C7ZEL4s3Tsx4rRoTdy2l5sVppOCViz/ToFBMFM9h5eLU
         675zJRzfjOBHcbcf/fqIsV8GcVcTDcR8WetZMirDPxwSkOwPCynyj7c8zdLekufxcQ
         BsW8dXU9EUPjownhVubxXbCndz6dsSeLOCFKVreI=
Date:   Mon, 9 Nov 2020 13:29:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 03/32] spi: dw: Fix driving MOSI low while recieving
Message-ID: <20201109132935.GB6380@sirena.org.uk>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-4-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <20201107081420.60325-4-damien.lemoal@wdc.com>
X-Cookie: This fortune is false.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 07, 2020 at 05:13:51PM +0900, Damien Le Moal wrote:

> The resting state of MOSI is high when nothing is driving it. If we
> drive it low while recieving, it looks like we are transmitting 0x00
> instead of transmitting nothing. This can confuse slaves (like SD cards)
> which allow new commands to be sent over MOSI while they are returning
> data over MISO. The return of MOSI from 0 to 1 at the end of recieving
> a byte can look like a start bit and a transmission bit to an SD card.

If client devices are interpreting the transmitted data then I would
expect the drivers for that hardware to be ensuring that whatever we
transmit matches what the device is expecting.  We shouldn't be putting
a hack in a particular controller driver to paper over things, that will
mean that the device will break when used with other controllers and if
different devices have different requirements then obviously we can't
satisfy them.  There is not meaningfully a general specification for SPI
which says what happens when signals are idle, it's all specific to the
client device.

In this case it also looks like the controller hardware requires
transmit data and therefore should be setting SPI_MUST_TX and just
removing the in driver default anyway, though that will have no effect
one way or anther on the issue you're seeing.

Please also try to avoid the use of master/slave terminology where
reasonable, controller and device tend to work for SPI (though MOSI/MISO
are going to be harder to shift).

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+pRD4ACgkQJNaLcl1U
h9C5TAf/XbwBOxTibzpvLt8ovg4q6S5JE6AAQVhlhvghT7Yf7yrHRWjzb0yS6iYp
KQb6/34eaIvIS48nMgl+1nODQGH7gALefdHDVJgWJzW2pz66UBMG8Eg5DzUagnZM
QrFDJwjghbqyKutTPSYyJqYkhdzxZH15TlJeAu43BVuAF0c7Znxpk3apXr54b6J0
nXV+CGRukYMHoT0kcNAZRG/znjrFFxUz8yBtAqR6Ue2AvSU3QGDVU7O+JHlRfMj6
SPeCXxvDhVBz7Sbo+XWoesnhzGza5+1fQdYSur9vVxjKmrI5pbxBZpBXHJ2WvTnt
HSXi47r4tVbbZC4W3BBRJPE6KTFQLA==
=2gHP
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
