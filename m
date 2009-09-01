From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 1/2] add ad714x platform_data
	definition
Date: Tue, 1 Sep 2009 14:41:03 -0400
Message-ID: <8bd0f97a0909011141p144a927cg39e6bf0313165a8@mail.gmail.com>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com>
	<1251777330-16994-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: dbrownell@users.sourceforge.net, dmitry.torokhov@gmail.com,
	dtor@mail.ru, spi-devel-general@lists.sourceforge.net,
	uclinux-dist-devel@blackfin.uclinux.org,
	linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1251777330-16994-2-git-send-email-21cnbao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Aug 31, 2009 at 23:55, Barry Song<21cnbao@gmail.com> wrote:
> --- /dev/null
> +++ b/include/linux/spi/ad714x.h
> @@ -0,0 +1,60 @@
> +/*
> + * include/linux/ad714x.h
> + *
> + * AD714x is very flexible, it can be used as buttons, scrollwheel,
> + * slider, touchpad at the same time. That depends on the boards.
> + * The platform_data for the device's "struct device" holds this
> + * information.
> + */

missing lines:
 * Copyright 2009 Analog Devices Inc.
 *
 * Licensed under the GPL-2 or later.

> +#ifndef AD714X_HW_H
> +#define AD714X_HW_H

header files should not be using an unprefixed name space (even if
it's an uncommon define name), and the name really should match the
header.  i.e. __LINUX_SPI_AD714X_H__
-mike
