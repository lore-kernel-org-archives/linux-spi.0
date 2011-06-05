From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: reorganize drivers
Date: Sun, 5 Jun 2011 14:57:48 -0600
Message-ID: <BANLkTimnqZzwMAH8nqr2hN55Lcmiznr6+Q@mail.gmail.com>
References: <20110605071725.26517.11573.stgit@ponder> <BANLkTinoEQf2a65KwQZOVK_4H9DSfqybjA@mail.gmail.com>
 <20110605075458.GA2712@tarshish> <BANLkTi=K-kP4wFd2PP3JkPVs9FEm1ebCBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Baruch Siach <baruch@tkos.co.il>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTi=K-kP4wFd2PP3JkPVs9FEm1ebCBw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, Jun 5, 2011 at 7:12 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> Hi Baruch,
>
> On Sun, Jun 5, 2011 at 1:24 PM, Baruch Siach <baruch@tkos.co.il> wrote:
>>> Though the spi_ prefix seems redundant considering the files are in
>>> 'spi' directory.
>>> Just a thought, no objection.
>>
>> When looking at the list of loaded modules (e.g. in an Oops message), the name
>> "spi_xilinx" is much more meaningful than just "xilinx", for example.
> Good catch.
> Perhaps we could get Makefile to build modules with spi_ prefix. Just
> like USB gadgets do ?

I don't think it's worth mucking about with <module_name>-y :=
filename.o when the filename can just be made the same as the module
name.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
