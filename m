Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFCBC433F5
	for <linux-spi@archiver.kernel.org>; Tue,  3 May 2022 05:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiECFmP (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 3 May 2022 01:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiECFmN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 May 2022 01:42:13 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417E739BA5;
        Mon,  2 May 2022 22:38:42 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id a5so11610730qvx.1;
        Mon, 02 May 2022 22:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sYbCI8Jfawj/+cLFvyH4OtiicE1oM1tlrNoa7PX+yxo=;
        b=JkIqDFEHCLdnyJV6h9j+AROfvdE2y5cJfpVVqKaY51bFHmmV4uVUp5a1kh0CogbCeV
         Eosl8vMySFLmcueevULz14R4Pwvjf59nAIyo7xpAGSZIBz/ZU9qD2hCiS8ktRMijULqA
         INooKVrx/6uPVCo8YdNYHNg/30GsgIQBwPMXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sYbCI8Jfawj/+cLFvyH4OtiicE1oM1tlrNoa7PX+yxo=;
        b=V6YNENqJqlPWiz4FQd4Kw0T5QO3X42iJ+4prCVW5vM6w5X/V6mvVdhRoEJY2EbK1VG
         LrRmYZ/e3+sf3UCnJfPbGCU8MmuZn2V4HG8rAbq6kILZyZNCAfOtZcD6mcNwd+ulzpXy
         IhweS3MeHOKAasj4iJ8mP4P/mYe1Y5tBEUIxZksElPQ8lDSFWX+H8W66HsjzxNml2hBE
         efmCnrvetqkjZ6bH98xcbf5zQCpgejMv77lpUg80uSy/JUrK3CJ4EkHOPsXix8EHZUsB
         X6uiSnyjKvU254AGBfQFapktbNkY3mY4SmUWNBZM5rVqP98kfNOF+uE9bVhQjFUErbMX
         q2+Q==
X-Gm-Message-State: AOAM531Mb1Y6TRpcKEuVkwiCKQMsnBu5vnxbZcbTJe6VDISFs9bCSYNy
        3T3Uvbnk/B+aNTpQzaa9GmxxAywE0P2ZSjw4G9GmejXBMk0=
X-Google-Smtp-Source: ABdhPJzXKglgbfvc/y22kbBrPqAYKdyIcG7c6Vcs397WzlemAGmThQTODYEvOIFE9BAsACLJuFhVRSrhAEFAwm+yhpU=
X-Received: by 2002:a05:6214:624:b0:441:84f3:24e3 with SMTP id
 a4-20020a056214062400b0044184f324e3mr12263372qvx.27.1651556321359; Mon, 02
 May 2022 22:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220502081341.203369-1-clg@kaod.org>
In-Reply-To: <20220502081341.203369-1-clg@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 3 May 2022 05:38:29 +0000
Message-ID: <CACPK8XfxsXgVHKY3tqgs=-ZX95jkpjcG_4HE=igG4QBULd0vRA@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] spi: spi-mem: Convert Aspeed SMC driver to spi-mem
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     linux-spi@vger.kernel.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 2 May 2022 at 08:13, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> This series adds a new SPI driver using the spi-mem interface for the
> Aspeed static memory controllers of the AST2600, AST2500 and AST2400
> SoCs.

I put this into the OpenBMC yocto tree, which pushes it through CI and
does a qemu boot on Romulus. I also tested on Palmetto in qemu and the
AST2600A3 EVB.

 https://gerrit.openbmc-project.xyz/c/openbmc/openbmc/+/51551

It looks good.

Tested-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
