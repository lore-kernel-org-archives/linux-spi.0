Return-Path: <SRS0=LFB0=5K=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604FCC2D0E5
	for <linux-spi@archiver.kernel.org>; Wed, 25 Mar 2020 20:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F2A20719
	for <linux-spi@archiver.kernel.org>; Wed, 25 Mar 2020 20:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585168367;
	bh=weSonQ6U+D8luEhNB8lX8BJxLp1w6o6JkOl8aHppaqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PMKC1OJIqO3SNzzTwUnvGt2zdNE1jaIb40xUT0SXucXkpZSAdEmaj9oDzYcVHv4Yo
	 6jWlXR2cp/SiKMHDtV2OiV/pxXISoCWxby1q03pYB7j3to2fAib8/G4DpvZXdIoRLr
	 9c87Gx317Hdxj8G4jiTS2wmGcW2lTXyKr7UNWfkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgCYUcq (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:32:46 -0400
Received: from foss.arm.com ([217.140.110.172]:52818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbgCYUcq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 25 Mar 2020 16:32:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0899430E;
        Wed, 25 Mar 2020 13:32:46 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F1C13F71E;
        Wed, 25 Mar 2020 13:32:45 -0700 (PDT)
Date:   Wed, 25 Mar 2020 20:32:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [linux-next:master 1837/11710] sh4-linux-ld: cannot find
 drivers/spi/.tmp_gl_spi-mux.o: No such file or directory
Message-ID: <20200325203244.GD12169@sirena.org.uk>
References: <202003260124.NDYYFnCI%lkp@intel.com>
 <3ec603f5379aafd36f80490ef78108b225eac030.camel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
In-Reply-To: <3ec603f5379aafd36f80490ef78108b225eac030.camel@alliedtelesis.co.nz>
X-Cookie: Do not stamp.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2020 at 08:30:16PM +0000, Chris Packham wrote:
> On Thu, 2020-03-26 at 01:38 +0800, kbuild test robot wrote:

> >    rm: cannot remove 'drivers/spi/.tmp_gl_spi-mux.o': No such file or
> > directory
> >    rm: cannot remove 'drivers/spi/.tmp_mx_spi-mux.o': No such file or
> > directory

> I attempted to reproduce this. The sh4 toolchain was unhappy with my
> system (missing libisl.so.22). I bodged something together and got
> errors like this all over the place. I also tried the previous commit
> and still got the same errors.

I'm not overly worried about it TBH - it looks like either an issue with
the architecture or an infrastructure issue, this is plain C code not
doing anything fancy and if this were an error in the code I'd expect
that other architectures would be seeing similar problems.

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl57v+sACgkQJNaLcl1U
h9BISwf+IZMbDoYOhKIWMWqP1SfWlKdbW9Vn5MyQrrG0qMaYycNlpIg7rH7NStEB
u1D0jxU6Nq8YjtzKXrcURzjA76t8yAVnOzCpL09JXeGBOpwbgOFADHMX+BDjGwqX
iUyQKyhm13IRxs2rIx2gqGb8QUZL7S16hsX/COqGBHWlmeCIW9YLLQM7d/+ZgYWf
8/kHVoTKzuAvWG0qfEDj4RXla5IkG/CbJPLHIyiern16LQ3c+H2HRLOJRk4EQBfv
4ig834LF0RFhcguR9utNZhlp4KK0EdvTTOwV7oEkZAcVVNkD2YOwStq9FYqBl9mY
edEAWMkAQ4dYMOOwic8fXdKPI646pg==
=nWg4
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--
