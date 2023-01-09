Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CFDC54EBD
	for <linux-spi@archiver.kernel.org>; Mon,  9 Jan 2023 19:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbjAITGT (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 9 Jan 2023 14:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbjAITGT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Jan 2023 14:06:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAE0B4BD;
        Mon,  9 Jan 2023 11:06:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41784612FB;
        Mon,  9 Jan 2023 19:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A56C433D2;
        Mon,  9 Jan 2023 19:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673291176;
        bh=FsrF2Ro9sJgDi7TtUdBWS5NIoq7OU0wrJTZ91H57yTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hOmD/NqGtsOU1cgj7jr/7NebRYjHHLsOywOHXQfjgFm6JRAwJkDfXnEo8dplZ0kfP
         HhCfGoFD1Rm6zlUCNDVadgSwE+AyAL3Qt0u4L5gBweOE6OUy47WMW2emaOuOKeyEXf
         Im0pNBFxbCSbMvqtFVyiKdM4wygXzj0/Zb/KQd+d670+JxVTI1hfAXU6DJmTGKpItK
         z9gW90gzlYvS/6n6JewRiT0Zwskt+LMWkgwNBxQ7JvoX/sc9ixSgndYTEzl1AysySE
         G3bKAkFhYk450h7kl+eif9jrUw/7FYurPwO4h5HqZUTqNgG6s1Ve0zo1UHUP6O2Gg/
         p/kyZHQHBYdPw==
Date:   Mon, 9 Jan 2023 19:06:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/16] spi: bcm63xx-hsspi: Add polling mode support
Message-ID: <Y7xloRuHk5BHSOCb@sirena.org.uk>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-8-william.zhang@broadcom.com>
 <Y7iW38Fsj0nIewDm@sirena.org.uk>
 <ec84b84b-41be-32ad-2e76-afac59a621d0@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5HqRRYJJbMpHDR2G"
Content-Disposition: inline
In-Reply-To: <ec84b84b-41be-32ad-2e76-afac59a621d0@broadcom.com>
X-Cookie: Editing is a rewording activity.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5HqRRYJJbMpHDR2G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 06, 2023 at 07:35:59PM -0800, William Zhang wrote:
> On 01/06/2023 01:47 PM, Mark Brown wrote:
> > On Fri, Jan 06, 2023 at 12:07:59PM -0800, William Zhang wrote:

> > > When interrupt is not defined in the HSSPI dts node, driver switches to
> > > polling mode for controller SPI message processing.  Also add driver
> > > banner message when the driver is loaded successfully.

> > This should not be something the user selects via the DT, if the polling
> > mode is better then the driver should just use it regardless of there
> > being an interrupt wired up.  Generally there's some point at which the
> > benefits of polling become minimal (and the costs more impactful) but if
> > the DMA setup is as bad as it sounds then the driver should just ignore
> > the interrupt.

> I agree but this is more for backward compatibility as the original driver
> uses interrupt to work with MIPS based SoC and I do not want to change that
> behavior.  For newer devices I added, they work in polling mode by default
> with the dts I supplied.  IMHO it is also good to have this fallback option
> to use interrupt in case user is sensitive to cpu usage.

You can put whatever logic is needed in the code - for something like
this an architecture based define isn't ideal but is probably good
enough if need be (though I'd not be surprised if it turned out that
there was also some performance benefit for the MIPS systems too, at
least for smaller transfers).

--5HqRRYJJbMpHDR2G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO8ZaEACgkQJNaLcl1U
h9CV6wf/cG0BlL3QXcA4PCDR+DndbCMNxAB5I/YCjZucCrKmqH/QeswtCXCdEZbk
C1R/hO/MTyhXWZBm1xR2KqHL2x/yeoJyRmOjmia3YGjfO6rISSmenKS8bcUbq8gF
N+TzgS8QoxJxoXBcgWNxA+DpHFxiu17+rYpDvWnAFRB0FOrPW4CCeX3aWoEAHJ1+
QzuAx+pix0iPxFrPiGqBOSEKLUZUgwiOGgaBfA4xguZMA9ehudIK6TO/rQ1eQIjS
KfSXZ9hkm37Gzqdez/wmRvHIblBbSS/+vpx83OnTmVerC98qvdbYXdNR2OI40m5I
LDWtN3dpqmZBYW77sjpEPPNRTrP4MQ==
=Ht9K
-----END PGP SIGNATURE-----

--5HqRRYJJbMpHDR2G--
