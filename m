From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH v2] spi: reorganize drivers
Date: Mon, 06 Jun 2011 09:49:20 -0700
Message-ID: <4DED0510.1030600@gmail.com>
References: <20110606071829.10334.90865.stgit@ponder> <BANLkTinqVf+uK+5T_X-EkXw-YE67DJL1Pg@mail.gmail.com> <BANLkTinmfufSkSnmiKWWEgpaR-usbiV5tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mike Frysinger <vapier.adi@gmail.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTinmfufSkSnmiKWWEgpaR-usbiV5tA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 06/06/2011 09:38 AM, Grant Likely wrote:
> On Mon, Jun 6, 2011 at 10:31 AM, Mike Frysinger<vapier.adi@gmail.com>  wrote:
>> On Mon, Jun 6, 2011 at 03:18, Grant Likely wrote:
>>> Sort the SPI makefile and enforce the naming convention spi_*.c for
>>> spi drivers.
>>
>> spi_topcliff_pch.c uses KBUILD_MODNAME with a few funcs, but perhaps
>> those are only for /proc/ status tracking ?  worth double checking ...
>
> I just talked with Dirk Brandewie, who has a major rewrite to the
> topcliff spi driver.  I'll let him comment on whether or not changing
> KBUILD_MODNAME will cause any problems.
>

My changes are to the designware driver :-) I will get my patches re-based onto 
the spi-next branch and see if there any issues.

--Dirk
