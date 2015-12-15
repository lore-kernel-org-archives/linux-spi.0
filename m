From: Michal Suchanek <hramrach@gmail.com>
Subject: Re: [PATCH v6 06/10] mtd: spi-nor: simplify write loop
Date: Wed, 16 Dec 2015 00:45:30 +0100
Message-ID: <CAOMqctS91RB1UoyhXwSEyikNh7=KJViOyLcGYyiAoO2-nqcjOg@mail.gmail.com>
References: <cover.1449052427.git.hramrach@gmail.com> <2236d87ad516f118f58eb5df232d441f970c4499.1449052427.git.hramrach@gmail.com>
 <20151215202216.GA11742@chopperman.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Rafal Milecki <zajec5@gmail.com>,
	Jagan Teki <jteki@openedev.com>,
	"Andrew F. Davis" <afd@ti.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Gabor Juhos <juhosg@openwrt.org>,
	Bean Huo <beanhuo@micron.com>,
	Furquan Shaikh <furquan@google.com>,
	MTD Maling List <linux-mtd@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>
To: Han Xu <han.xu@freescale.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151215202216.GA11742@chopperman.am.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 15 December 2015 at 21:22, Han Xu <han.xu@freescale.com> wrote:
> On Wed, Dec 02, 2015 at 10:38:20AM +0000, Michal Suchanek wrote:
>> The spi-nor write loop assumes that what is passed to the hardware
>> driver write() is what gets written.
>>
>> When write() writes less than page size at once data is dropped on the
>> floor. Check the amount of data writen and exit if it does not match
>> requested amount.
>>
>> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
>>
>> ---
>>
>>  - add warning when writing incomplete pages
>>  - refuse to continue writing when full page was not written
>> ---
>>  drivers/mtd/spi-nor/spi-nor.c | 58 +++++++++++++++++++------------------------
>>  1 file changed, 25 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index 3d02803..115c123 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -1005,8 +1005,8 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>>       size_t *retlen, const u_char *buf)
>>  {
>>       struct spi_nor *nor = mtd_to_spi_nor(mtd);
>> -     u32 page_offset, page_size, i;
>> -     int ret;
>> +     size_t page_offset, page_remain, i;
>> +     ssize_t ret;
>>
>>       dev_dbg(nor->dev, "to 0x%08x, len %zd\n", (u32)to, len);
>>
>> @@ -1014,45 +1014,37 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>>       if (ret)
>>               return ret;
>>
>> -     write_enable(nor);
>> -
>> -     page_offset = to & (nor->page_size - 1);
>> +     for (i = 0; i < len; ) {
>> +             ssize_t written;
>>
>> -     /* do all the bytes fit onto one page? */
>> -     if (page_offset + len <= nor->page_size) {
>> -             ret = nor->write(nor, to, len, buf);
>> -             if (ret < 0)
>> -                     goto write_err;
>> -             *retlen += ret;
>> -     } else {
>> +             page_offset = to & (nor->page_size - 1);
>> +             WARN_ONCE(page_offset,
>> +                       "Writing at offset %zu into a NOR page. Writing partial pages may decrease reliability and increase wear of NOR flash.",
>> +                       page_offset);
>>               /* the size of data remaining on the first page */
>> -             page_size = nor->page_size - page_offset;
>> -             ret = nor->write(nor, to, page_size, buf);
>> +             page_remain = min_t(size_t,
>> +                                 nor->page_size - page_offset, len - i);
>> +
>> +             write_enable(nor);
>> +             ret = nor->write(nor, to + i, page_remain, buf + i);
>
> Previous implementation was trying to write nor->page_size byte data in
> each loop, except the first and last loop, if possible. But this change
> may write only (nor->page_size - page_offset) in each loop, for the
> worst case, if page_offset equals nor->page_size -1, it writes byte by
> byte.

Indeed, there should be to + i when determining page_offset.

Thanks

Michal
