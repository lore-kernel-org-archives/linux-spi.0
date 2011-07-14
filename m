From: Thomas De Schampheleire <patrickdepinguin+spidevel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: FSL eSPI driver: incorrect buffer offset for received bytes
Date: Thu, 14 Jul 2011 16:46:07 +0200
Message-ID: <CAAXf6LVL7vxu76Tawqacrm1HirdnSfv1pMFL8W2S8d36RYhUXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ronny Meeus <ronny.meeus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

I am having problems with the eSPI driver on Freescale P40xx, while
accessing an EEPROM memory device (AT25040). I prepare an spi_transfer
structure with a tx and rx buffer, and e.g. len = 6 (bytes).

This transfer is eventually handled by fsl_espi_do_one_msg(). Below
are some excerpts (note: these come from a slightly older version of
the driver, but judging from the code newer versions exhibit the same
problems I'm discussing here):

        u8 *rx_buf = NULL;
        list_for_each_entry(t, &m->transfers, transfer_list) {
                [...]
                if (t->tx_buf)
                        n_tx += t->len;

                if (t->rx_buf) {
                        n_rx += t->len;
                        rx_buf = t->rx_buf;
                }
        }

Here, we have one rx_buf local to the function, and an t->rx_buf per
transfer. The transfer list is iterated, and each time a transfer has
a non-NULL rx_buf pointer, the function-local rx_buf is overwritten.
I do not understand this: all previous values of rx_buf are lost. The
way I see it, this code can only work if there is only one transfer
handled at a time in fsl_espi_do_one_msg().
Am I forgetting something?


Later on, a new transfer list is assembled, with tx and rx buffers
strung together in one local_buf.

        list_for_each_entry(t, &m->transfers, transfer_list) {
                if (t->tx_buf) {
                        memcpy(local_buf + i, t->tx_buf, t->len);
                        i += t->len;
                }
        }

        trans.len = n_tx + n_rx;
        trans.tx_buf = local_buf;
        trans.rx_buf = local_buf + n_tx;
        spi_message_add_tail(&trans, &message);

So local_buf is structured as follows: (assuming 3 transfers in the
list, with tx0 / rx0 the corresponding set of bytes for each transfer)

| tx0 | tx1 | tx2 | ... | rx0 | rx1 | rx2 | ...

What I do not understand is why trans.len is set to the sum of n_tx
and n_rx. The eSPI controller is normally doing full-duplex
transactions, in which tx and rx happens at the same time. If I want
to receive 6 bytes, I also have to send 6 bytes.
Could you explain why trans.len is double the original t->len?


Then, still in fsl_espi_do_one_msg(), the transfer is initiated with
fsl_espi_bufs(). After that, the received data is copied back:

        list_for_each_entry(t, &message.transfers, transfer_list) {
                [...]
                if (rx_buf)
                        memcpy(rx_buf, t->rx_buf + n_tx, n_rx);
                [...]
        }

As mentioned above, I cannot imagine that this works if there is more
than one transfer in the list, since rx_buf will always point to the
buffer of the last transfer.

But more importantly, I think that the from-offset in the memcpy
statement is incorrect: the interrupt routine has placed the received
bytes at trans.rx_buf, which was set to local_buf + n_tx. In the
current memcpy statement, an extra n_tx is added to the receive
buffer, so in fact it becomes trans.rx_buf + 2*n_tx. Given the layout
of the local_buf, memcpy is going to copy the wrong bytes.

This is indeed what I see when reading my EEPROM device: if I request
6 bytes at offset 0, the first 2 bytes I receive are 0xffff (which is
normal; this is the data sent by the device while receiving the opcode
and read offset), followed by four 'real' bytes coming from memory,
but from memory offset 4 (6 (transfer length) - 2 (EEPROM device first
two dummy bytes)). The larger the transfer length, the farther apart
the returned and expected bytes are.

If I patch the eSPI driver, so that the memcpy is looking as follows,
then I receive the bytes that I expect. No incorrect offset is used.

        list_for_each_entry(t, &message.transfers, transfer_list) {
                [...]
                if (rx_buf)
                        memcpy(rx_buf, t->rx_buf, n_rx);
                [...]
        }


Am I missing something in my analysis, or is this really a bug?

Thanks,
Thomas

------------------------------------------------------------------------------
AppSumo Presents a FREE Video for the SourceForge Community by Eric 
Ries, the creator of the Lean Startup Methodology on "Lean Startup 
Secrets Revealed." This video shows you how to validate your ideas, 
optimize your ideas and identify your business strategy.
http://p.sf.net/sfu/appsumosfdev2dev
