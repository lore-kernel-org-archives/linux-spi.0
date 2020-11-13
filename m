Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCAAC63697
	for <linux-spi@archiver.kernel.org>; Fri, 13 Nov 2020 15:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C558620A8B
	for <linux-spi@archiver.kernel.org>; Fri, 13 Nov 2020 15:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgKMPrC (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 13 Nov 2020 10:47:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:37904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgKMPqo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 13 Nov 2020 10:46:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B05B7ABD9;
        Fri, 13 Nov 2020 15:46:41 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     chris.packham@alliedtelesis.co.nz, linux-kernel@vger.kernel.org
Cc:     andy.shevchenko@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Subject: Re: [PATCH v5 2/2] spi: Add generic SPI multiplexer
Date:   Fri, 13 Nov 2020 16:46:33 +0100
Message-Id: <20201113154633.21542-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20200204032838.20739-3-chris.packham@alliedtelesis.co.nz>
References: <20200204032838.20739-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Upon registering spi-mux's devices through spi_add_device() the kernel gets
stuck waiting for the 'spi_add_lock' mutex to be released. The mutex happens to
be held by spi-mux's parent SPI bus, which unluckily, is waiting for spi-mux's
probe to finish before releasing it.

I might aswell be doing something wrong. But so far I trust my DT
implementation:

	&spi {
		status = "okay";
		pinctrl-names = "default";
		pinctrl-0 = <&spi0_gpio7>;

		spi@0 {
			compatible = "spi-mux";
			reg = <0>;
			#address-cells = <1>;
			#size-cells = <0>;
			spi-max-frequency = <100000000>;

			mux-controls = <&gpio_mux>;

			w5500@0 {
				compatible = "wiznet,w5500";
				reg = <0>;
				pinctrl-names = "default";
				pinctrl-0 = <&eth1_pins>;
				interrupt-parent = <&gpio>;
				interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
				spi-max-frequency = <30000000>;
			};

			spi-flash@1 {
				compatible = "jedec,spi-nor";
				reg = <1>;
				#address-cells = <1>;
				#size-cells = <0>;
				spi-max-frequency = <16000000>;
			};
		};
	};

Regards,
Nicolas
