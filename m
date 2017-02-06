From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: rspi: fix the bug related to mount/remount jffs2
Date: Mon, 6 Feb 2017 12:02:07 +0100
Message-ID: <CAMuHMdUyA9+KLaD9rY9gYjxjZcQ1bWKoDhP25mEAdZTr7E0uwA@mail.gmail.com>
References: <1486342933-5307-1-git-send-email-cv-dong@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi <linux-spi@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        =?UTF-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung@jinso.co.jp>,
        =?UTF-8?B?56iy5ZCJ?= <h-inayoshi@jinso.co.jp>,
        Cao Minh Hiep <cm-hiep@jinso.co.jp>
To: DongCV <cv-dong@jinso.co.jp>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1486342933-5307-1-git-send-email-cv-dong@jinso.co.jp>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Dong,

On Mon, Feb 6, 2017 at 2:02 AM, DongCV <cv-dong@jinso.co.jp> wrote:
> From: Dong <cv-dong@jinso.co.jp>
>
> This patch fixes the output warning logs and data loss when
> performing mount/umount then remount the device with jffs2 format.
>
> This is the warning logs when performing mount/umount then remount the device with jffs2 format:
> "root@linaro-naro:~# mount -t jffs2 /dev/mtdblock2 /mnt/media
> [ 3839.928013] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40000: 0x1900 instead
> [ 3839.956515] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40004: 0x000c instead
> [ 3839.985009] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40008: 0xb0b1 instead
> [ 3840.013591] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b4000c: 0x1900 instead
> [ 3840.042087] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40010: 0x0044 instead
> [ 3840.070566] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40014: 0xfb1d instead
> [ 3840.099159] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40018: 0x0002 instead
> [ 3840.127604] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b4001c: 0x0001 instead
> [ 3840.156043] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40020: 0x81a4 instead
> [ 3840.184472] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b4002c: 0x6529 instead
> [ 3840.212900] jffs2: Further such events for this erase block will not be printed
> [ 3840.322915] jffs2: notice: (2008) read_dnode: node CRC failed on dnode at 0x3b40080: read 0xc40b5dfc, calculated 0x264be003
> root@linaro-naro[ 3840.356857] jffs2: warning: (2008) jffs2_do_read_inode_internal: no data nodes found for ino #2
> :~# [ 3840.386659] jffs2: Returned error for crccheck of ino #2. Expect badness...
>
> Signed-off-by: Dong <cv-dong@jinso.co.jp>
> ---
>  drivers/spi/spi-rspi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index 9daf500..2ee1301 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -848,7 +848,6 @@ static int qspi_transfer_in(struct rspi_data *rspi, struct spi_transfer *xfer)
>                         ret = rspi_pio_transfer(rspi, NULL, rx, n);
>                         if (ret < 0)
>                                 return ret;
> -                       *rx++ = ret;
>                 }
>                 n -= len;
>         }

Apart from sending patches inline, my comments from
https://www.spinics.net/lists/linux-spi/msg09753.html are still valid.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
