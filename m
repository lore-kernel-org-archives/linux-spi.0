From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] spi: pl022: Fix race in giveback() leading to driver
 lock-up
Date: Fri, 27 Feb 2015 16:30:21 +0100
Message-ID: <54F08D8D.5000705@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Wilshire Jay <jay.wilshire.ext-OYasijW0DpE@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi: pl022: Fix race in giveback() leading to driver lock-up

Commit fd316941c ("spi/pl022: disable port when unused") introduced a race,
which leads to possible driver lock up (easily reproducible on SMP).

The problem happens in giveback() function where the completion of the transfer
is signalled to SPI subsystem and then the HW SPI controller is disabled. Another
transfer might be setup in between, which brings driver in locked-up state.

Exact event sequence on SMP:

core0                                   core1

                                        => pump_transfers()
                                        /* message->state == STATE_DONE */
                                          => giveback()
                                            => spi_finalize_current_message()

=> pl022_unprepare_transfer_hardware()
=> pl022_transfer_one_message
  => flush()
  => do_interrupt_dma_transfer()
    => set_up_next_transfer()
    /* Enable SSP, turn on interrupts */
    writew((readw(SSP_CR1(pl022->virtbase)) |
           SSP_CR1_MASK_SSE), SSP_CR1(pl022->virtbase));

...

=> pl022_interrupt_handler()
  => readwriter()

                                        /* disable the SPI/SSP operation */
                                        => writew((readw(SSP_CR1(pl022->virtbase)) &
                                                  (~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));

Lockup! SPI controller is disabled and the data will never be received. Whole
SPI subsystem is waiting for transfer ACK and blocked.

So, only signal transfer completion after disabling the controller.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-pl022.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index ad78766..6aea517 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -508,12 +508,12 @@ static void giveback(struct pl022 *pl022)
 	pl022->cur_msg = NULL;
 	pl022->cur_transfer = NULL;
 	pl022->cur_chip = NULL;
-	spi_finalize_current_message(pl022->master);
 
 	/* disable the SPI/SSP operation */
 	writew((readw(SSP_CR1(pl022->virtbase)) &
 		(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
 
+	spi_finalize_current_message(pl022->master);
 }
 
 /**
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
