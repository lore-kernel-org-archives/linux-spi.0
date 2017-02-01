From: DongCV <cv-dong-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: Re: [PATCH] spi: rspi: fix the bug related to mount/remount jffs2
Date: Wed, 1 Feb 2017 16:08:18 +0900
Message-ID: <ed5a6bff-67b8-f893-2306-de00e3a8ec30@jinso.co.jp>
References: <74ea1835-3ce3-612c-ece5-52c8dba0ca87@jinso.co.jp>
 <CAMuHMdVZOOLGziGm4YdHn_bRB_JOzWEeQ=Ogr8TiB47KTza7OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Ryusuke Sakato <ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        inux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        =?UTF-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>,
        =?UTF-8?B?56iy5ZCJ?= <h-inayoshi-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>,
        Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdVZOOLGziGm4YdHn_bRB_JOzWEeQ=Ogr8TiB47KTza7OA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Dear Geert,

I apologize for the delayed response.
I have reviewed the code. I saw that rx and tx are incremented in the 
rspi_pio_transfer() function.
" if (rx) {
       int ret = rspi_data_in(rspi);
       if (ret < 0)
           return ret;
       *rx++ = ret;
   }"

The same case for tx.
" if (tx) {
      int ret = rspi_data_out(rspi, *tx++);
      if (ret < 0)
         return ret;
   }"

I've retested on Lager(H2) with v4.10-rc2 afterI added the patch "spi: 
rspi: fix the bug related to mount/remount jffs2".
I have tried to read/write a data from/to device, then using cmp command 
to compare destination data and source data.
Result is the destination data is same to the source data.


Regards,
Dong


On 01/27/2017 06:00 PM, Geert Uytterhoeven wrote:
> Hi Dong,
>
> On Fri, Jan 27, 2017 at 9:12 AM, DongCV <cv-dong-HEF513clHfp3+QwDJ9on6Q@public.gmane.org> wrote:
>> This patch fixes the output warning logs and data loss when performing
>> mount/umount then remount the device with jffs2 format.
>> This patch is tested on Lager board at Linux uptream v4.10-rc5.
>> Please consider the patch for Renesas-soc Gen2
> Please send patches inline.
>
>>  From 5513c6a02c911fcf9f99d5188fa46256aa1e41b4 Mon Sep 17 00:00:00 2001
>> From: Dong <cv-dong-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
>> Date: Fri, 27 Jan 2017 16:29:18 +0900
>> Subject: [PATCH] spi: rspi: fix the bug related to mount/remount jffs2
>>
>> This patch fixes the output warning logs and data loss when
>> performing mount/umount then remount the device with jffs2 format.
>>
>> This is the warning logs when performing mount/umount then remount the device with jffs2 format:
>> "root@linaro-naro:~# mount -t jffs2 /dev/mtdblock2 /mnt/media
>> [ 3839.928013] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40000: 0x1900 instead
>> [ 3839.956515] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40004: 0x000c instead
>> [ 3839.985009] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40008: 0xb0b1 instead
>> [ 3840.013591] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b4000c: 0x1900 instead
>> [ 3840.042087] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40010: 0x0044 instead
>> [ 3840.070566] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40014: 0xfb1d instead
>> [ 3840.099159] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40018: 0x0002 instead
>> [ 3840.127604] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b4001c: 0x0001 instead
>> [ 3840.156043] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40020: 0x81a4 instead
>> [ 3840.184472] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b4002c: 0x6529 instead
>> [ 3840.212900] jffs2: Further such events for this erase block will not be printed
>> [ 3840.322915] jffs2: notice: (2008) read_dnode: node CRC failed on dnode at 0x3b40080: read 0xc40b5dfc, calculated 0x264be003
>> root@linaro-naro[ 3840.356857] jffs2: warning: (2008) jffs2_do_read_inode_internal: no data nodes found for ino #2
>> :~# [ 3840.386659] jffs2: Returned error for crccheck of ino #2. Expect badness...
>>
>> Signed-off-by: Dong <cv-dong-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
>> ---
>>   drivers/spi/spi-rspi.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
>> index 9daf500..2ee1301 100644
>> --- a/drivers/spi/spi-rspi.c
>> +++ b/drivers/spi/spi-rspi.c
>> @@ -848,7 +848,6 @@ static int qspi_transfer_in(struct rspi_data *rspi, struct spi_transfer *xfer)
>>                        ret = rspi_pio_transfer(rspi, NULL, rx, n);
>>                        if (ret < 0)
>>                                return ret;
>> -                     *rx++ = ret;
> Storing the success code (0) in the receive buffer is indeed wrong.
>
> However, there are other bugs in that code:
>
> rspi_pio_transfer(rspi, NULL, rx, n) transfers n bytes instead of len,
> while n is decreased by len (which is <= n).
> Furthermore rx is not incremented.
> Hence if len < n, n will still be non-zero, and a new iteration of the
> loop will be started, trying to receive more data, and overwriting the
> just filled buffer.
>
> The same bug is present in qspi_transfer_out().
>
>>                }
>>                n -= len;
>>        }
>> --
>> 1.9.1
>>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
