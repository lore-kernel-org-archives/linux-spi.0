From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] spi: reorganize drivers
Date: Sun, 5 Jun 2011 18:42:45 +0530
Message-ID: <BANLkTi=K-kP4wFd2PP3JkPVs9FEm1ebCBw@mail.gmail.com>
References: <20110605071725.26517.11573.stgit@ponder>
	<BANLkTinoEQf2a65KwQZOVK_4H9DSfqybjA@mail.gmail.com>
	<20110605075458.GA2712@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110605075458.GA2712@tarshish>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Baruch,

On Sun, Jun 5, 2011 at 1:24 PM, Baruch Siach <baruch@tkos.co.il> wrote:
>> Though the spi_ prefix seems redundant considering the files are in
>> 'spi' directory.
>> Just a thought, no objection.
>
> When looking at the list of loaded modules (e.g. in an Oops message), the name
> "spi_xilinx" is much more meaningful than just "xilinx", for example.
Good catch.
Perhaps we could get Makefile to build modules with spi_ prefix. Just
like USB gadgets do ?
