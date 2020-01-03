From: kongxinwei <kong.kongxinwei@hisilicon.com>
Subject: Re: [PATCH] spi: dw: use "smp_mb()" to avoid sending spi data error
Date: Fri, 3 Jan 2020 09:34:33 +0800
Message-ID: <fca15988-22eb-2ba9-037e-7f7f51221fe4@hisilicon.com>
References: <1577352088-35856-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <20191227002239.GH27497@sirena.org.uk>
 <afad8a97-6159-bf7e-466a-fdbaf0a07d4a@hisilicon.com>
 <20200103010409.GG3897@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, fengsheng <fengsheng5@huawei.com>,
        kXinwei Kong <kong.kongxinwei@hisilicon.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200103010409.GG3897@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 2020/1/3 9:04, Mark Brown wrote:
> On Sat, Dec 28, 2019 at 04:31:53PM +0800, kongxinwei wrote:
> 
>>> I'd be much more comfortable here if I understood what this was
>>> supposed to be syncing - what exactly gets flushed here and why
>>> is a memory barrier enough to ensure it's synced?  A comment in
>>> the code would be especially good so anyone modifying the code
>>> understands this in future.
> 
>> Because of out-of-order execution about some CPU architecture,
>> In this debug stage we find Completing spi interrupt enable ->
>> prodrucing TXEI interrupt -> running "interrupt_transfer" function
>> will prior to set "dw->rx and dws->rx_end" data, so it will result
>> in SPI sending error
> 
> Could you update the commit message to say that, and ideally also
> add a comment saying something like "Ensure dw->rx and dw->rx_end
> are visible" please?
> 
OK, i WILL update it.
