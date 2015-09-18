From: Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>
Subject: spi-imx: wait_for_completion should timeout even in non-DMA transfer cases
Date: Fri, 18 Sep 2015 14:38:27 +0200
Message-ID: <CAH-u=81E2RnMvm2UZxUasCSf6hMQtiMO9Y1VcNiy0pFR6Uy6vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

I am wondering why in spi-imx the spi_imx_pio_transfer() function is
calling wait_for_completion() and not wait_for_completion_timeout() as
in the spi_imx_dma_transfer() one.
I can't see a good reason for this, maybe should it be calculated
based on the spi clock and transfer->len, or at least be the same as
IMX_DMA_TIMEOUT which is 3 seconds ?
If you want it, I have a patch, just tell me if you are interested and
if you prefer a calculated timeout or even something else ?

Thanks,
JM
