From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH v4 01/12] misc: add driver for sequencer serial port
Date: Thu, 28 Oct 2010 14:14:14 -0400
Message-ID: <AANLkTinOROf6OqTjN0tZgoDr5ij3J18DHpC8wwArH3CO@mail.gmail.com>
References: <1288124308-14999-1-git-send-email-cyril@ti.com>
	<1288124308-14999-2-git-send-email-cyril@ti.com>
	<AANLkTi=rDep3jkp2QAjVsgjZ7JQ0ysnse4TARv29fyHm@mail.gmail.com>
	<4CC9A03F.80401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "davinci-linux-open-source@linux.davincidsp.com"
	<davinci-linux-open-source@linux.davincidsp.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"broonie@opensource.wolfsonmicro.com"
	<broonie@opensource.wolfsonmicro.com>,
	"lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>,
	"dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rpurdie@rpsys.net" <rpurdie@rpsys.net>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
To: cyril@ti.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CC9A03F.80401@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2010/10/28 Cyril Chemparathy <cyril@ti.com>:
> On 10/28/2010 11:49 AM, Linus Walleij wrote:
>> Why is this thing in drivers/misc?
>> drivers/mfd is IMHO the apropriate place for a driver like this, (..=
=2E)
>
> Alan had raised the same concern earlier, and my response was:
>
>[Cyril]
>> Unlike MFDs, this device doesn't have cells with differing
>> functionality. =A0Instead it has functionally identical ports that c=
an
>> operate in a variety of modes. =A0That said, does this still fit in =
with
>> other MFD drivers? =A0If so, I don't see a problem with moving it th=
ere.
>
> I don't see a problem with moving this into MFD, but this won't be ab=
le
> to use any of the functionality provided by mfd-core.

I think they do have differing functionality, though not in their
essence (hardware), they do get a clearly defined role at
run-time.

Sam will tell, but since you have subdrivers in other
subsystems MFD fits best IMHO.

What about the platform data passed into the MFD driver defines
what type of functionality will be assigned to each physical
block, from that you create the array of MFD cells to be spawn
and spawn it off. Then you have platform_driver:s in each
subsystem attaching to said cells. Shouldn't be too hard.

Yours,
Linus Walleij
