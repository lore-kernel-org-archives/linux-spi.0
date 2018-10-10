From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] eeprom: at25: Use spi_message_init_with_transfers()
 instead of open coding
Date: Wed, 10 Oct 2018 16:02:04 +0200
Message-ID: <CAK8P3a3XuZ4nZ7FJgi=m1L7tznjue4+77wd2KYe_qGH=zaEZMg@mail.gmail.com>
References: <20181010134036.8296-1-geert+renesas@glider.be>
 <20181010134317.8466-1-geert+renesas@glider.be> <20181010134317.8466-3-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010134317.8466-3-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 10/10/18, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> Reduce code duplication in at25_ee_read() by using the
> spi_message_init_with_transfers() helper.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Arnd Bergmann <arnd@arndb.de>
