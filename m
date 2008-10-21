From: "Joakim Tjernlund" <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Performance of spi_mpc83xx.c sucks.
Date: Tue, 21 Oct 2008 18:19:08 +0200
Message-ID: <1224605947.14078.17.camel@gentoo-jocke.transmode.se>
Reply-To: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "spi-devel-general" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

We have noticed that the spi_mpc83xx.c driver is very slow, the gap
between words are huge.
So I started to optimise it and it still sucks.
However, if I poll the SPIE_NF SPIE_NE bits instead it works MUCH
better, like so:
		struct mpc83xx_spi_reg *regs = mpc83xx_spi->base;
		u32 event=SPIE_NF;

		mpc83xx_spi->tx_count -= 1;
		word = mpc83xx_spi->get_tx(mpc83xx_spi);
		mpc83xx_spi_write_reg(&regs->transmit, word);
		if (len >= 2) { /* FIFO is 2 words */
			mpc83xx_spi->tx_count -= 1;
			word = mpc83xx_spi->get_tx(mpc83xx_spi);
			mpc83xx_spi_write_reg(&regs->transmit, word);
		}
		clear_need_resched();
		do {
			if (event & SPIE_NE) {
				word = mpc83xx_spi_read_reg(&regs->receive);
				mpc83xx_spi->rx_count -= 1;
				if (mpc83xx_spi->rx)
					mpc83xx_spi->get_rx(word, mpc83xx_spi);

				if ((event & SPIE_NF) && mpc83xx_spi->tx_count) {
					mpc83xx_spi->tx_count -= 1;
					word = mpc83xx_spi->get_tx(mpc83xx_spi);
					mpc83xx_spi_write_reg(&regs->transmit, word);
				}

			} else if (need_resched()){
				clear_need_resched();
				schedule();
				printk("Cond, rx:%d\n", mpc83xx_spi->rx_count);
			}

			event = mpc83xx_spi_read_reg(&regs->event);
			} while (mpc83xx_spi->rx_count);

I am not sure what this polling will do to the system though. Is this really bad to do?
The resched() stuff doesn't seem to work, probably becase I don't know how
to use it properly :(

 Jocke



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
