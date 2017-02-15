From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] spi: rspi: Fixes bogus received byte in
 qspi_transfer_in()
Date: Wed, 15 Feb 2017 15:17:52 +0300
Message-ID: <f54e33bf-a320-54c9-c4b2-2db3ded0e99e@cogentembedded.com>
References: <1487155852-12102-1-git-send-email-cv-dong@jinso.co.jp>
 <1487155852-12102-2-git-send-email-cv-dong@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com,
        ryusuke.sakato.bx@renesas.com, linux-renesas-soc@vger.kernel.org,
        nv-dung@jinso.co.jp, h-inayoshi@jinso.co.jp, cm-hiep@jinso.co.jp
To: DongCV <cv-dong@jinso.co.jp>, broonie@kernel.org,
        geert+renesas@glider.be, linux-spi@vger.kernel.org
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1487155852-12102-2-git-send-email-cv-dong@jinso.co.jp>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 02/15/2017 01:50 PM, DongCV wrote:

> In qspi_transfer_in(), when receiving the last n (or len) bytes of data,
> one bogus byte was written in the receive buffer.
> This code leads to a buffer overflow.
>
> "jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found
> at 0x03b40000: 0x1900 instead
> jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found
> at 0x03b40004: 0x000c instead"
>
> The error message above happens when trying to mount, unmount,
> and remount a jffs2-formatted device.
> This patch removed the bogus write to fixes: 3be09bec42a800d4
> "spi: rspi: supports 32bytes buffer for DUAL and QUAD"

    You were just asked to add the following tag to the patch (e.g. before 
your signoff):

Fixes: 3be09bec42a8 ("spi: rspi: supports 32bytes buffer for DUAL and QUAD")

This simplifies the propagation of the patch to the -stable releases...

> And here is Geert's comment:
>
> "spi: rspi: Fix bogus received byte in qspi_transfer_in()
> When there are less than QSPI_BUFFER_SIZE remaining bytes to be received,
> qspi_transfer_in() writes one bogus byte in the receive buffer, possibly
> leading to a buffer overflow.
> This can be reproduced by mounting, unmounting, and remounting a
> jffs2-formatted device, causing lots of warnings like:
>
> "jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found
> at 0x03b40000: 0x1900 instead"
>
> Remove the bogus write to fix this. "

    I don't think effectively duplicating your patch description makes sense here.

> Signed-off-by: DongCV <cv-dong@jinso.co.jp>

    Need full name here.

> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
[...]

MBR, Sergei
