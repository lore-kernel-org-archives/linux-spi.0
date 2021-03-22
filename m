Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52DAC433E6
	for <linux-spi@archiver.kernel.org>; Mon, 22 Mar 2021 13:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8323B61930
	for <linux-spi@archiver.kernel.org>; Mon, 22 Mar 2021 13:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhCVNXu (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 22 Mar 2021 09:23:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45812 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhCVNWi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Mar 2021 09:22:38 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12MDKScU111557;
        Mon, 22 Mar 2021 08:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616419228;
        bh=26DPjYQQRL+10iBnOu2PfjSw1h9HtqmQpGx0mKS6rfc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=X1qtgf3E6OtWvC74sm9vBiyMIKB8KkHDLR26uraWd4kzAJg4cX+yZ58v2jnguNrQF
         SE8MJz+4mLoiflb4ve9bUdtgY4xu4lsc4vh42a27i0U2VAddUv383tdkDGp4vMzgjK
         gD0xXheAIufthqa7WfJqm6HvrJfXc1EGE9JUM72Y=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12MDKRVA120742
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Mar 2021 08:20:27 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 22
 Mar 2021 08:20:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 22 Mar 2021 08:20:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12MDK7dk112900;
        Mon, 22 Mar 2021 08:20:08 -0500
Date:   Mon, 22 Mar 2021 18:50:06 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to json schema
Message-ID: <20210322132004.n4r2thznsm7poq74@ti.com>
References: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
 <20210315183051.ugvmz4zqrvuo6iqq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210315183051.ugvmz4zqrvuo6iqq@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 16/03/21 12:00AM, Pratyush Yadav wrote:
> +Cc mtd list
> 
> Hi,
> 
> On 15/03/21 05:45PM, Kuldeep Singh wrote:
> > Convert the Freescale DSPI binding to DT schema format using json-schema.
> > 
> > Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> > ---
> > Hi Rob,
> > This patch is checked with following commands with no warnings observed.
> > make distclean; make allmodconfig;
> > make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml;
> > make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
> 
> When I add the "fsl,spi-cs-sck-delay" property under the flash@0 node in 
> the example and run dt_binding_check, I see the below error:
> 
>   /home/pratyush/src/linux/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.example.dt.yaml: flash@0: 'fsl,spi-cs-sck-delay' does not match any of the regexes: '^partition@', 'pinctrl-[0-9]+'
>      From schema: /home/pratyush/src/lin/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> 
> I am trying to solve a similar problem for the Cadence QSPI controller 
> binding and I wonder what the best solution for this is. The obvious one 
> would be to add these properties to jedec,spi-nor.yaml. I haven't 
> managed to come up with any other solution to this problem.
> 
> Rob, all, any suggestions on how to best model this?

Ping. Any ideas?

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
