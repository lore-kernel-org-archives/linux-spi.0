Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A51C64EC4
	for <linux-spi@archiver.kernel.org>; Thu,  9 Mar 2023 07:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCIHwK (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 9 Mar 2023 02:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjCIHvu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Mar 2023 02:51:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEE62B9DF;
        Wed,  8 Mar 2023 23:50:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8202A61A5C;
        Thu,  9 Mar 2023 07:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DB2C433EF;
        Thu,  9 Mar 2023 07:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678348176;
        bh=j43Kdz7FrZlQoUq7oQqRGTx4xGidoyi/zGWD0kHgqGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cNvJk8fl6t2PZgjF5XIVmZHSUv9hzmnw5OOHuF3t0HfUpxl5V/FmpEsFPvAlRGxPK
         pN3oURUnBxecm1yKNdHh9frEw1qDQYYa5CUrrUZVUwtIevd7m4MooWxsxd7kxM2lNm
         vdTkfHvqyQ7+gC9VCvvoujQh39jPAtEUa0GFc0WU=
Date:   Thu, 9 Mar 2023 08:49:33 +0100
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
Subject: Re: [PATCH v4 1/5] mfd: Add support for Intel LJCA device
Message-ID: <ZAmPjfH6rA0pbiUa@kroah.com>
References: <20230309071100.2856899-1-xiang.ye@intel.com>
 <20230309071100.2856899-2-xiang.ye@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309071100.2856899-2-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Mar 09, 2023 at 03:10:56PM +0800, Ye Xiang wrote:
> This patch implements the USB part of Intel USB-I2C/GPIO/SPI adapter
> device named "La Jolla Cove Adapter" (LJCA).

Then why is this called "mfd" in the subject line?

>  include/linux/mfd/ljca.h  |  95 ++++

Why is this .h file in the mfd directory?

thanks,

greg k-h
