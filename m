Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3247C2D0A3
	for <linux-spi@archiver.kernel.org>; Mon,  9 Nov 2020 15:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E3B206C0
	for <linux-spi@archiver.kernel.org>; Mon,  9 Nov 2020 15:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604935933;
	bh=LdUacPIOLrIqn9CdpUBSmiVlcE4JMo1ObnCv0BUo5q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ol6LGsDpb6ypyY/zsgaOYfz5H8gep+CUjrNadQoA4QpEqpYdLhfxDdZLk7IkhdHis
	 D50L/7k9cOtL5yNQJMipOlNe85mfMeVDuvbZhvQKnW5PKEzR2E/lGHRG+F98WID9ON
	 cb4Vx+1aS22x74O5zSBKT7PfCjzuNcGt+DlA1uwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgKIPcN (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 9 Nov 2020 10:32:13 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38139 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbgKIPcM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 10:32:12 -0500
Received: by mail-ot1-f67.google.com with SMTP id a15so7562479otf.5;
        Mon, 09 Nov 2020 07:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O/MhRiDM2XLsUq3m1Qal43ednQtGsrnCRzGf4Dwfv8A=;
        b=q39JjO5PYwGw5zQ6j6zi4TSqDZVoZhjBsFltNum/jQa/Cp6hZc6wPt7oRCxeSXUo7q
         qmFymR1p0tCQzLqo39xmqq3voZ2C5SFbbsrO3sj8lyCj2dbX7HqqZIqzXaCz10z4GQHZ
         L41TWDc542z3XjGBgiHohY7yojofRStjEvz3t2UwNpLHXPb8chyV55aczX286N5LLyc/
         sEQMLFsUi621FLFPDbg6puxNN+0jYbNb4sHcX7hH+g6AUkpgBblumkbyQVjUqLPjDFvq
         xRFnXyKNrNCMpWJOHyrjfoAHCJw9H4Rw5SfXmvMjNJyByYrUueFkg6Y8s9nBqLhT7yMa
         cyDQ==
X-Gm-Message-State: AOAM533X8M8NU1XnDl5nViRP5VEWMShaBx25dZ/lnFgg0ZAXRFqUfPpL
        5NSL10d+RZHZtLm/XxiW7w==
X-Google-Smtp-Source: ABdhPJyVDlLobHGRODhe5D+jhGh+NZj7eFU7nY/tPIVmlrM37y0bv23zcdQvuPUcKBTpMfyTSN1GOQ==
X-Received: by 2002:a9d:64c7:: with SMTP id n7mr10134080otl.137.1604935931440;
        Mon, 09 Nov 2020 07:32:11 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g18sm250938otp.23.2020.11.09.07.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 07:32:10 -0800 (PST)
Received: (nullmailer pid 1330007 invoked by uid 1000);
        Mon, 09 Nov 2020 15:32:09 -0000
Date:   Mon, 9 Nov 2020 09:32:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Sean Anderson <seanga2@gmail.com>, linux-spi@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 22/32] dt-binding: Document kendryte,k210-sysctl bindings
Message-ID: <20201109153209.GA1329063@bogus>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-23-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107081420.60325-23-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 07 Nov 2020 17:14:10 +0900, Damien Le Moal wrote:
> Document the device tree bindings of the Kendryte K210 SoC system
> controller driver in
> Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  .../bindings/mfd/kendryte,k210-sysctl.yaml    | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml:23:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml: properties:clocks: 'oneOf' conditional failed, one must be fixed:
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml: properties:clocks: 'anyOf' conditional failed, one must be fixed:
		/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml: properties:clocks: 'oneOf' conditional failed, one must be fixed:
			'minItems' is not one of ['maxItems']
			'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'default', '$ref']
		/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml: properties:clocks: 'oneOf' conditional failed, one must be fixed:
			'items' is not one of ['maxItems']
			'items' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'default', '$ref']
		'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'default', '$ref']
		1 is less than the minimum of 2
	'minItems' is not one of ['type', 'description', 'dependencies', 'properties', 'patternProperties', 'additionalProperties', 'unevaluatedProperties', 'deprecated', 'required', 'allOf', 'anyOf', 'oneOf', '$ref']
	'maxItems' is not one of ['type', 'description', 'dependencies', 'properties', 'patternProperties', 'additionalProperties', 'unevaluatedProperties', 'deprecated', 'required', 'allOf', 'anyOf', 'oneOf', '$ref']
	'items' is not one of ['type', 'description', 'dependencies', 'properties', 'patternProperties', 'additionalProperties', 'unevaluatedProperties', 'deprecated', 'required', 'allOf', 'anyOf', 'oneOf', '$ref']
	'type' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml: ignoring, error in schema: properties: clocks
warning: no schema found in file: ./Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml


See https://patchwork.ozlabs.org/patch/1396076

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

