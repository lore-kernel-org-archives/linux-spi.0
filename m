Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3F5C43217
	for <linux-spi@archiver.kernel.org>; Mon, 20 Sep 2021 17:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0441B615A6
	for <linux-spi@archiver.kernel.org>; Mon, 20 Sep 2021 17:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348551AbhITRj7 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 20 Sep 2021 13:39:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48390 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346366AbhITRh6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 13:37:58 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18KHaIG1046675;
        Mon, 20 Sep 2021 12:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632159378;
        bh=JehA/AdZ62AVPkLLoqCPDg/CoSo8j/lugoyiuCZiRnQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=elLuM0fsfzsZXoNfsPZJ0028D7v8svy0M1v3N4mDFayb5MTLhASXfrWpE2DcT/yoD
         WGlkPW2v5JXRjlJ+8vSgrXy46vPhiVWP+gdmAj98X9HdZ/gy750TskcPWB4z95ngrz
         xwvhFeKniuXdJWpfkPtVNklXp2F7FHxn83oJw1Vo=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18KHaIA1042167
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Sep 2021 12:36:18 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Sep 2021 12:36:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Sep 2021 12:36:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18KHaGp4011525;
        Mon, 20 Sep 2021 12:36:17 -0500
Date:   Mon, 20 Sep 2021 23:06:15 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Apurva Nandan <a-nandan@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <michael@walle.cc>
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: spi-nand: Convert to DT schema
 format
Message-ID: <20210920173613.oqk6lnmipabkt25s@ti.com>
References: <20210920142713.129295-1-a-nandan@ti.com>
 <20210920142713.129295-2-a-nandan@ti.com>
 <20210920150651.vvdhennblwhdi3jw@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210920150651.vvdhennblwhdi3jw@mobilestation>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 20/09/21 06:06PM, Serge Semin wrote:
> Hello Apurva
> 
> On Mon, Sep 20, 2021 at 07:57:12PM +0530, Apurva Nandan wrote:
> > Convert spi-nand.txt binding to YAML format with an added example.
> > 
> > Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> > ---
> >  .../devicetree/bindings/mtd/spi-nand.txt      |  5 --
> >  .../devicetree/bindings/mtd/spi-nand.yaml     | 62 +++++++++++++++++++
> >  2 files changed, 62 insertions(+), 5 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
> >  create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml
[...]
> 
> > +  spi-max-frequency: true
> > +  spi-rx-bus-width: true
> > +  spi-tx-bus-width: true
> > +  rx-sample-delay-ns: true
> 
> Since it's an SPI-client device there are more than these properties
> could be set for it. See the SPI-controller bindings schema:
> Documentation/devicetree/bindings/spi/spi-controller.yaml
> So there is two possible ways to make it more generic:
> 1) Detach the spi-client part from the spi-controller.yaml bindings
> into a dedicated DT-schema file and refer to that new scheme from
> here.
> 2) Forget about these controller-specific properties and let the
> parental SPI-controller bindings parsing them. Of course there must be
> at least one of the next properties declared for it to work:
> {unevaluatedProperties, additionalProperties}.

I proposed a patch series [0] to fix this for SPI NOR, which can be used 
here as well. A re-roll is long overdue though. Let me see when I can 
find time to get to it. In the meantime, this should be fine IMO.

[0] https://patchwork.kernel.org/project/spi-devel-general/list/?series=497129&state=%2A&archive=both


-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
