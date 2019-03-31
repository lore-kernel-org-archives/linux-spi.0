From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH] spi: bcm-qspi: when tx/rx buffer is NULL set to 0
Date: Sun, 31 Mar 2019 10:40:35 -0400
Message-ID: <CAC=U0a3iidc1UyvXfedVBrPPU2qL9SomWu6yJwiMKpoXHwok=g@mail.gmail.com>
References: <1549572447-45456-1-git-send-email-justinpopo6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi <linux-spi@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
To: justinpopo6@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549572447-45456-1-git-send-email-justinpopo6@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Feb 7, 2019 at 3:47 PM <justinpopo6@gmail.com> wrote:
>
> From: Justin Chen <justinpopo6@gmail.com>
>
> Currently we set the tx/rx buffer to 0xff when NULL. This causes
> problems with some spi slaves where 0xff is a valid command. Looking
> at other drivers, the tx/rx buffer is usually set to 0x00 when NULL.
> Following this convention solves the issue.
>
> Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

 Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

> ---
>  drivers/spi/spi-bcm-qspi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
> index 584bcb0..79456aa 100644
> --- a/drivers/spi/spi-bcm-qspi.c
> +++ b/drivers/spi/spi-bcm-qspi.c
> @@ -681,7 +681,7 @@ static void read_from_hw(struct bcm_qspi *qspi, int slots)
>                         if (buf)
>                                 buf[tp.byte] = read_rxram_slot_u8(qspi, slot);
>                         dev_dbg(&qspi->pdev->dev, "RD %02x\n",
> -                               buf ? buf[tp.byte] : 0xff);
> +                               buf ? buf[tp.byte] : 0x00);
>                 } else {
>                         u16 *buf = tp.trans->rx_buf;
>
> @@ -689,7 +689,7 @@ static void read_from_hw(struct bcm_qspi *qspi, int slots)
>                                 buf[tp.byte / 2] = read_rxram_slot_u16(qspi,
>                                                                       slot);
>                         dev_dbg(&qspi->pdev->dev, "RD %04x\n",
> -                               buf ? buf[tp.byte] : 0xffff);
> +                               buf ? buf[tp.byte] : 0x0000);
>                 }
>
>                 update_qspi_trans_byte_count(qspi, &tp,
> @@ -744,13 +744,13 @@ static int write_to_hw(struct bcm_qspi *qspi, struct spi_device *spi)
>         while (!tstatus && slot < MSPI_NUM_CDRAM) {
>                 if (tp.trans->bits_per_word <= 8) {
>                         const u8 *buf = tp.trans->tx_buf;
> -                       u8 val = buf ? buf[tp.byte] : 0xff;
> +                       u8 val = buf ? buf[tp.byte] : 0x00;
>
>                         write_txram_slot_u8(qspi, slot, val);
>                         dev_dbg(&qspi->pdev->dev, "WR %02x\n", val);
>                 } else {
>                         const u16 *buf = tp.trans->tx_buf;
> -                       u16 val = buf ? buf[tp.byte / 2] : 0xffff;
> +                       u16 val = buf ? buf[tp.byte / 2] : 0x0000;
>
>                         write_txram_slot_u16(qspi, slot, val);
>                         dev_dbg(&qspi->pdev->dev, "WR %04x\n", val);
> --
> 2.7.4
>
