From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: Re: [spi-devel-general] [patch 05/14] mfd: PCAP2 driver
Date: Sat, 22 Nov 2008 22:01:58 +0800
Message-ID: <f17812d70811220601p1d7af668mf3265224179753ab@mail.gmail.com>
References: <20081121160403.073751031@dodger.lab.datenfreihafen.org>
	 <20081121160521.016544616@dodger.lab.datenfreihafen.org>
	 <200811212125.49068.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net, stefan@datenfreihafen.org,
	sameo@openedhand.com, linux-arm-kernel@lists.arm.linux.org.uk,
	"Daniel Ribeiro" <drwyrm@gmail.com>, linux-kernel@vger.kernel.org
To: "David Brownell" <david-b@pacbell.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758258AbYKVOCT@vger.kernel.org>
In-Reply-To: <200811212125.49068.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Nov 22, 2008 at 1:25 PM, David Brownell <david-b@pacbell.net> wrote:
> On Friday 21 November 2008, stefan@datenfreihafen.org wrote:
>> Since the last submission we are also using the spi subsystem and
>> pxa2xx-spi instead of ssp.c directly as before.
>
> I took a quick glance at this and it seemed like it should be
> able to build without depending on PXA ... should certainly
> not include <mach/ssp.h> or <mach/regs-ssp.h>, and it doesn't
> look like it needs PXA-specific stuff like <mach/mfp-pxa27x.h>
> either.
>
> It's also worth removing the reverse dependencies ("select X")
> from Kconfig; they don't work very well for the things which
> those dependencies rely on.
>
> - Dave
>

I'm wondering if it call fall into the regulator framework, along with
a hwmon driver with its attributes being exported by sysfs.
