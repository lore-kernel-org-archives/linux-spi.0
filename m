From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 0/2] add ad714x captouch sensor input
	driver
Date: Tue, 1 Sep 2009 14:46:27 -0400
Message-ID: <8bd0f97a0909011146t210cbacbx6b0fa323242ac3d3@mail.gmail.com>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: dbrownell@users.sourceforge.net, dmitry.torokhov@gmail.com,
	dtor@mail.ru, spi-devel-general@lists.sourceforge.net,
	uclinux-dist-devel@blackfin.uclinux.org,
	linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1251777330-16994-1-git-send-email-21cnbao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Aug 31, 2009 at 23:55, Barry Song wrote:
> David,
> The patch[1/2] adds a file with platform_data definition for AD714x in include/linux/spi,
> which describes the components layout on special target boards and need be filled in
> arch/mach.

i dont think this needs to split merged between David's spi and
Dmitry's input tree.  would make more sense to me to merge it as one
patchset via Dmitry's input tree.

> Dmitry,
> The patch[2/2] adds a file in drivers/input/misc and changes Kconfig&Makefile, fulfilling
> the algorithms and state machines for the related buttons/sliders/scrollwheels/touchpads
> defined in platform_data. So the driver becomes be independent of special target boards.

looks like your patch [2/2] is incomplete as it doesnt include any
Kconfig or Makefile changes
-mike
