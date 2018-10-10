From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] eeprom: at25: Split writes in two SPI transfers to
 optimize DMA
Date: Wed, 10 Oct 2018 16:03:13 +0200
Message-ID: <CAK8P3a1=rWcDaO9eu56us09=yy8CfakgFSGtLW1xfRyVhUT69g@mail.gmail.com>
References: <20181010134036.8296-1-geert+renesas@glider.be>
 <20181010134317.8466-1-geert+renesas@glider.be> <20181010134317.8466-4-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010134317.8466-4-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 10/10/18, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> Currently EEPROM writes are implemented using a single SPI transfer,
> which contains all of command, address, and payload data bytes.
> As some SPI controllers impose limitations on transfers with respect to
> the use of DMA, they may have to fall back to PIO. E.g. DMA may require
> the transfer length to be a multiple of 4 bytes.
>
> Optimize writes for DMA by splitting writes in two SPI transfers:
>   - The first transfer contains command and address bytes,
>   - The second transfer contains the actual payload data, now stored at
>     the start of the (kmalloc() aligned) buffer, to improve payload
>     alignment.
>
> E.g. for a 25LC040 EEPROM with a page size 16 bytes, a 16-byte write
> aligned to the page size was transferred using an 18-byte write.
> After this change, the write is split in a 2-byte and an aligned 16-byte
> write.
>
> Note that EEPROM reads already use a similar scheme, due to the
> different data directions for command and address bytes versus payload
> data.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Arnd Bergmann <arnd@arndb.de>
