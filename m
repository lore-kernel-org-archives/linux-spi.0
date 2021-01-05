Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64910C433DB
	for <linux-spi@archiver.kernel.org>; Tue,  5 Jan 2021 13:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 329DD2226A
	for <linux-spi@archiver.kernel.org>; Tue,  5 Jan 2021 13:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbhAENsZ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 5 Jan 2021 08:48:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbhAENsZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 Jan 2021 08:48:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 249C5229C4;
        Tue,  5 Jan 2021 13:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609854464;
        bh=gyD3KQsl/AH0kP2J/k+P8mYvYMg3e/UjEIFD6A8fcvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSa3SxhMtQZX4I4QN+P9vlGTpDtlaMd0kAhgiI4Xg5NudWKM4YTEtA+yAsyePqL2E
         a5TrYWlX3wEipkE6kvVYHuKGP/hFOs4JGSloH+8WJ5UcLnLmkajcaMY6TgdyUaHVSQ
         2/3BQH/4Paqie6W6Ow2OjI5iUInSSmk4W8klSN+CoRyjn0bZ67quO2yTzyrYqmphV8
         4fy0ScZ8kGM8Y1lgPITWDqDfkaRmYEpRGkhJKYl571Zc8DC899tvYr/L6sPV6X9vMT
         HuMK1OFnId9k/ak3R6ZDnRN89wIhU0VGEdh4a/pi5qqkCpVFQ3pvMz11zdbjghMBXQ
         AywMuXT0STKOQ==
Date:   Tue, 5 Jan 2021 13:47:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: Realtek RTL838x/RTL839x SPI
 controller
Message-ID: <20210105134717.GB4487@sirena.org.uk>
References: <20210101132432.2785663-1-bert@biot.com>
 <20210101132432.2785663-2-bert@biot.com>
 <20210104213131.GL5645@sirena.org.uk>
 <121d9dc6-7993-d43b-291f-74dd943f4fc6@biot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <121d9dc6-7993-d43b-291f-74dd943f4fc6@biot.com>
X-Cookie: I'm ANN LANDERS!!  I can SHOPLIFT!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 05, 2021 at 09:43:59AM +0100, Bert Vermeulen wrote:
> On 1/4/21 10:31 PM, Mark Brown wrote:

> > This is still just using rtl-spi as the compatible string, please
> > address the feedback on the previous version.

> The rtl prefix really is as close as it gets. This is being developed on
> RTL838x and RTL839x, but the driver very likely also works on RTL8196C and
> RTL93xx series. There's no difference to the SPI block in those SoCs.

> Do you really want a different per-series compatible when the "IP block" was
> just copy-pasted between series in hardware?

Yes.

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/0beQACgkQJNaLcl1U
h9CzbggAgtHmArcCO+zD5/jomt+uuZzBWmKO40hICk9ya9e58s2nPiLdcG64gf0z
8qM/Q7wnRH6J2Hs/0Gaz8+3yqetgAeAX2cYCnxX8ONS3GmkVhwb7TJc8RH6WyxdY
/Kq+kS6bzJw8swB4kIj3dOKDPNXjMPZWwrp1IfcJ5UFbxJqgrd9T3VBcjJbN5U2I
IQBwNqWah7X6+tvTsWl44D1tgihjdS5SU537y9SNOi+uWm636qjBSlTIKK6PDlUe
ufgLQmiHHj9vm+jA/PaXD1Q7nOENIoty9xwHaZFMlxd4zU4X0G7xj2R38EoqT7nS
uGvqYC9o4iyHI+uHP2IZis1UNSPmow==
=yxIH
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
