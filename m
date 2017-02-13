From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: rspi: fix the bug related to mount/remount jffs2
Date: Mon, 13 Feb 2017 09:26:12 +0100
Message-ID: <CAMuHMdW58idbkvxSAY5L7TK72Va-Rbs=oN44CyUosjP7ajsiGQ@mail.gmail.com>
References: <1486342933-5307-1-git-send-email-cv-dong@jinso.co.jp> <20170206124639.eoxom7dxspippjmg@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: DongCV <cv-dong@jinso.co.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi <linux-spi@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        =?UTF-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung@jinso.co.jp>,
        =?UTF-8?B?56iy5ZCJ?= <h-inayoshi@jinso.co.jp>,
        Cao Minh Hiep <cm-hiep@jinso.co.jp>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170206124639.eoxom7dxspippjmg@sirena.org.uk>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Feb 6, 2017 at 1:46 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Feb 06, 2017 at 10:02:13AM +0900, DongCV wrote:
>> From: Dong <cv-dong@jinso.co.jp>
>>
>> This patch fixes the output warning logs and data loss when
>> performing mount/umount then remount the device with jffs2 format.
>
> This is not a good changelog since it does not describe what the problem
> with the driver is or how the change fixes it - it just says that there
> is a problem.
>
>> This is the warning logs when performing mount/umount then remount the device with jffs2 format:
>> "root@linaro-naro:~# mount -t jffs2 /dev/mtdblock2 /mnt/media
>> [ 3839.928013] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40000: 0x1900 instead
>> [ 3839.956515] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40004: 0x000c instead
>
> Please think hard before including long log messages in upstream
> reports, they often contain almost no useful information relative to
> their size so often obscure the relevant content in your message.  Some
> subset is usually much better (eg, "produces lots of errors like X"
> here).

May I suggest the following:

    spi: rspi: Fix bogus received byte in qspi_transfer_in()

    When there are less than QSPI_BUFFER_SIZE remaining bytes to be received,
    qspi_transfer_in() writes one bogus byte in the receive buffer, possibly
    leading to a buffer overflow.

    This can be reproduced by mounting, unmounting, and remounting a
    jffs2-formatted device, causing lots of warnings like:

        jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found
at 0x03b40000: 0x1900 instead

    Remove the bogus write to fix this.

It's also a good idea to add a Fixes tag:

    Fixes: 3be09bec42a800d4 ("spi: rspi: supports 32bytes buffer for
DUAL and QUAD")

(the code was moved afterwards, but both the origin and the move were
 integrated in v4.10-rc1).

Finally:

    Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
