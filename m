From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Tue, 15 Oct 2013 23:40:29 +0530
Message-ID: <525D8515.6070702@ti.com>
References: <52566ACC.1080100@ti.com> <20131010101410.GG21581@sirena.org.uk>
 <52568AA3.9080203@ti.com> <20131011100839.GA21581@sirena.org.uk>
 <525CDB77.4040201@ti.com> <20131015111647.GX2443@sirena.org.uk>
 <525D2BB3.4020705@ti.com> <20131015124656.GM2443@sirena.org.uk>
 <525D41E2.30206@ti.com> <20131015180142.GS23337@ld-irv-0074.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Peter Korsgaard <peter@korsgaard.com>, balbi@ti.com,
 Mark Brown <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>, Trent Piepho <tpiepho@gmail.com>,
 dwmw2@infradead.org
To: Brian Norris <computersforpeace@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20131015180142.GS23337@ld-irv-0074.broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi Brian,
On Tuesday 15 October 2013 11:31 PM, Brian Norris wrote:
> Hi Sourav,
>
> On Tue, Oct 15, 2013 at 06:53:46PM +0530, Sourav Poddar wrote:
>> On Tuesday 15 October 2013 06:16 PM, Mark Brown wrote:
>>> On Tue, Oct 15, 2013 at 05:19:07PM +0530, Sourav Poddar wrote:
>>>> On Tuesday 15 October 2013 04:46 PM, Mark Brown wrote:
>>>>> Can you fix this by enabling the clock is enabled when you return the
>>>>> buffer to the MTD layer and then disabling the clock when the buffer is
>>>>> released?
>>>> Sorry, I did not get you here. With memory mapped read, there is no
>>>> buffer exchanged, everything takes place at the mtd layer only, what gets
>>>> exchanged is just the memory mapped address.
>>> The buffer is the memory mapped address - part of getting the address
>>> should be preparing the hardware for it.
>>>
>>>>       if (spi->mode&&   SPI_RX_MMAP) {
>>>>           printk("memory mapped mode set\n");
>>>> -        flash->mmap_read = true;
>>>> +        flash->mmap_read = spi->memory_map;
>>> So this probably needs to be a function call to get the buffer (and a
>>> corresponding one to free it).
>> So, the flow can be something like this:
>>
>> drivers/mtd/devices/m25p80.c
>> get_flash_buf()
>> {
>>      lock();
>>
>>       t[0] = GET_BUFFER;
>>       t[1] = buf;
>>       ......
>>
>>       spi_sync();
>>
>>      unlock();
>> }
>>
>> mtd_read
>> {
>>      get_flash_buf();
>>
>>      if (flash->buf) {
>>          memcpy();
>>         return 0;
>>    }
>> }
>>
>> Not sure, if free buf is needed as devm_* variant is used to allocate that
>> memory.
> I believe you are misplacing the discussion of devm_* variants. devm_*
> is only useful for resources allocated/mapped released/unmapped at probe
> and release time. They do not magically remove the burden of resource
> management for I/O and other dynamic operations.
>
> In this case, you are not working at probe time, and you are not
> actually allocating any memory--your 'get_flash_buf()' and corresponding
> 'release_flash_buf()' would not be allocating memory but would be
> ensuring that the HW and driver is in the correct state.
>
> Brian
Thanks for the reply. I got this.

It will be helpful if you can also comment on the thought process till 
now, as you can see from the
series that enabling quad and memory mapped support will effect both the 
SPI controller and
m25p80 side. If the changes proposed on m25p80 looks good to you.


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
