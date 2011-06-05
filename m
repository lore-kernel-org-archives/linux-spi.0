From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] spi: reorganize drivers
Date: Mon, 6 Jun 2011 02:49:36 +0530
Message-ID: <BANLkTin1eQUO-at=Y1VZ7m42eWYqrNzHTA@mail.gmail.com>
References: <20110605071725.26517.11573.stgit@ponder>
	<BANLkTinoEQf2a65KwQZOVK_4H9DSfqybjA@mail.gmail.com>
	<20110605075458.GA2712@tarshish>
	<BANLkTi=5XLxcZiBcZT8W4Gh+Ph_BUjs-yw@mail.gmail.com>
	<BANLkTimgbxmBnTN9Sb55-hkbBi1AEfiPdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Baruch Siach <baruch@tkos.co.il>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTimgbxmBnTN9Sb55-hkbBi1AEfiPdg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> On Sun, Jun 5, 2011 at 5:49 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>> Though the spi_ prefix seems redundant considering the files are in
>>>> 'spi' directory.
>>>> Just a thought, no objection.
>>>
>>> When looking at the list of loaded modules (e.g. in an Oops message), the name
>>> "spi_xilinx" is much more meaningful than just "xilinx", for example.
>>
>> Plus, when dropping the prefix, spi_xilinx.ko and gpio-xilinx.ko
>> become the same...
As I said, the modules could still be made spi_xilinx.ko from
drivers/spi/xilinx.c
and gpio_xilinx.ko from drivers/gpio/xilinx.c


On Mon, Jun 6, 2011 at 2:25 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> Perhaps we could get Makefile to build modules with spi_ prefix. Just
>> like USB gadgets do ?
> I don't think it's worth mucking about with <module_name>-y :=
> filename.o when the filename can just be made the same as the module
> name.
Well, the solution was for discarding the 'redundant' prefix and yet
have device specific
module names. Not just for the sake of it.

Anyways, I don't wanna be bitchy about it. I can buy at face value
from a maintainer.
I am ok with the proposed naming.

Cheers!
-j
