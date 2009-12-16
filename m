From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [spi-devel-general] [PATCH 1/2] spi: new SPI bus
	lock/unlockfunctions
Date: Wed, 16 Dec 2009 18:00:04 -0500
Message-ID: <8bd0f97a0912161500h1dd95f1cr7a978b67ab6278b4@mail.gmail.com>
References: <1253224997-7422-1-git-send-email-vapier@gentoo.org>
	<BD79186B4FD85F4B8E60E381CAEE19090200ED81@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	Yi Li <yi.li@analog.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935882AbZLPXAp@vger.kernel.org>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090200ED81@mi8nycmail19.Mi8.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 16, 2009 at 17:49, H Hartley Sweeten wrote:
> On Thursday, September 17, 2009 3:03 PM, Mike Frysinger wrote:
>>
>> From: Yi Li <yi.li@analog.com>
>>
>> For some MMC cards over SPI bus, it needs to lock the SPI bus for it=
s own
>> use. =C2=A0The SPI transfer must not be interrupted by other SPI dev=
ices that
>> share the SPI bus with SPI MMC card.
>>
>> This patch introduces 2 APIs for SPI bus locking operation.
>
> Has any additional work be done on this patchset?

nope

> It would be nice to finally have a solution that lets the mmc_spi dri=
ver
> work on a shared spi bus.

the latest patch is on the list for _anyone_ to contribute their fixes
to address the posted issues
-mike
