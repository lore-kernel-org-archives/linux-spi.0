Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC36C76196
	for <linux-spi@archiver.kernel.org>; Thu, 23 Mar 2023 18:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCWSFe (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 23 Mar 2023 14:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjCWSFd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Mar 2023 14:05:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A463DA270;
        Thu, 23 Mar 2023 11:05:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2888E6284F;
        Thu, 23 Mar 2023 18:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B43C433D2;
        Thu, 23 Mar 2023 18:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679594730;
        bh=0865JfiFypru3FJc8vbsQvn4GQFZBP1qlUEDcWCh/Yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OKs6VHVlxFd3kssyCa5WNZh9bqaD/EUq+z3FJehHT9Sk6YUwbBMf7LWnHIpcaAZ6B
         XA92fwloEDTSnzwb0ry4iBWzHLPTitwI6Hoy/2hS+t9UPG8VHYM2HIURbcu/taKksj
         KORCAzG7IAsoFSb4UOJyTAwGqQUjQA5WTda5zDaA=
Date:   Thu, 23 Mar 2023 19:05:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lee Jones <lee@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Tyrone Ting <kfting@nuvoton.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-usb@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org,
        srinivas.pandruvada@intel.com, heikki.krogerus@linux.intel.com,
        andriy.shevchenko@linux.intel.com, sakari.ailus@linux.intel.com,
        zhifeng.wang@intel.com, wentong.wu@intel.com, lixu.zhang@intel.com
Subject: Re: [PATCH v6 1/6] usb: Add support for Intel LJCA device
Message-ID: <ZByU4tbhkhnF4kMw@kroah.com>
References: <20230323172113.1231050-1-xiang.ye@intel.com>
 <20230323172113.1231050-2-xiang.ye@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323172113.1231050-2-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Mar 24, 2023 at 01:21:08AM +0800, Ye Xiang wrote:
> +config USB_LJCA
> +	tristate "Intel La Jolla Cove Adapter support"
> +	select AUXILIARY_BUS
> +	depends on USB
> +	help
> +	  This adds support for Intel La Jolla Cove USB-I2C/SPI/GPIO
> +	  Master Adapter (LJCA). Additional drivers such as I2C_LJCA,
> +	  GPIO_LJCA and SPI_LJCA must be enabled in order to use the
> +	  functionality of the device.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called ljca.

That's a very generic name for a USB driver, why not "usb_ljca"?

> +struct ljca_dev {
> +	struct usb_device *udev;

You didn't remove this like you said you would :(

