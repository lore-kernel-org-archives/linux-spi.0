From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH] spi: bitbang: Fix NULL pointer dereference in
 spi_unregister_master
Date: Thu, 16 May 2019 21:27:52 +0800
Message-ID: <0569fc4c-c6b0-4971-f6f7-800084fb1824@huawei.com>
References: <20190516075656.25880-1-yuehaibing@huawei.com>
 <20190516095148.GA5598@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <axel.lin@ingics.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <albeu@free.fr>,
        <lorenzo.bianconi@redhat.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190516095148.GA5598@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 2019/5/16 17:51, Mark Brown wrote:
> On Thu, May 16, 2019 at 03:56:56PM +0800, YueHaibing wrote:
> 
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
>> Call Trace:
>>  dump_stack+0xa9/0x10e
>>  ? __list_del_entry_valid+0x45/0xd0
>>  ? __list_del_entry_valid+0x45/0xd0
>>  __kasan_report+0x171/0x18d
>>  ? __list_del_entry_valid+0x45/0xd0
>>  kasan_report+0xe/0x20
> 
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative then it's
> usually better to pull out the relevant sections.

Thanks, got it.

> 
