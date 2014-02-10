From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: Fwd: [PATCH 2/2] spi: Add Qualcomm QUP SPI controller support
Date: Mon, 10 Feb 2014 17:54:11 +0200
Message-ID: <1392047651.2853.19.camel@iivanov-dev>
References: <1391705868-20091-1-git-send-email-iivanov@mm-sol.com>
	 <1391705868-20091-3-git-send-email-iivanov@mm-sol.com>
	 <CACceFXdUobQvN2hcv5kh+QL=o8bWM_PVkAtrOx+euZSeVDm8hQ@mail.gmail.com>
	 <214fe9fc7e62ab30bdfbb4ac5d1ee250.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	inux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, gavidov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	kgunda-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
To: dsneddon-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <214fe9fc7e62ab30bdfbb4ac5d1ee250.squirrel-mMfbam+mt9083fI46fginR2eb7JE58TQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Hi Daniel,

On Fri, 2014-02-07 at 16:34 +0000, dsneddon-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org wrote: 
> > From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>


<snip>

> > +
> > +static int spi_qup_set_state(struct spi_qup *controller, u32 state)
> > +{
> > +       unsigned long loop = 0;
> > +       u32 cur_state;
> > +
> > +       cur_state = readl_relaxed(controller->base + QUP_STATE);
> Make sure the state is valid before you read the current state.

Why? Controller is always left in valid state (after probe and every
transaction)? I know that CAF code contain this check, but now driver
is little bit different. I have made some tests and controller is
always in valid state in this point.

> > +       /*
> > +        * Per spec: for PAUSE_STATE to RESET_STATE, two writes
> > +        * of (b10) are required
> > +        */
> > +       if (((cur_state & QUP_STATE_MASK) == QUP_STATE_PAUSE) &&
> > +           (state == QUP_STATE_RESET)) {
> > +               writel_relaxed(QUP_STATE_CLEAR, controller->base +
> > QUP_STATE);
> > +               writel_relaxed(QUP_STATE_CLEAR, controller->base +
> > QUP_STATE);
> > +       } else {
> Make sure you don't transition from RESET to PAUSE.

I don't see this to be handled in CAF code. Could you give me
more details, please?

Right now possible state transactions are:

* if everything is fine:
  RESET -> RUN -> PAUSE -> RUN -> RESET 
* in case of error: 
  RESET -> RUN -> RESET 
  RESET -> RUN -> PAUSE -> RESET

Please correct me if I am wrong.

> > +
> > +static void spi_qup_fifo_read(struct spi_qup *controller,
> > +                             struct spi_transfer *xfer)
> > +{
> > +       u8 *rx_buf = xfer->rx_buf;
> > +       u32 word, state;
> > +       int idx, shift;
> > +
> > +       while (controller->rx_bytes < xfer->len) {
> > +
> > +               state = readl_relaxed(controller->base + QUP_OPERATIONAL);
> > +               if (0 == (state & QUP_OP_IN_FIFO_NOT_EMPTY))
> > +                       break;
> > +
> > +               word = readl_relaxed(controller->base + QUP_INPUT_FIFO);
> > +
> > +               for (idx = 0; idx < controller->bytes_per_word &&
> > +                    controller->rx_bytes < xfer->len; idx++,
> > +                    controller->rx_bytes++) {
> > +
> > +                       if (!rx_buf)
> > +                               continue;
> If there is no rx_buf just set rx_bytes to xfer->len and skip the loop
> entirely.

Well, FIFO buffer still should be drained, right?
Anyway. I am looking for better way to handle this.
Same applies for filling FIFO buffer.

> > +                       /*
> > +                        * The data format depends on bytes_per_word:
> > +                        *  4 bytes: 0x12345678
> > +                        *  2 bytes: 0x00001234
> > +                        *  1 byte : 0x00000012
> > +                        */
> > +                       shift = BITS_PER_BYTE;
> > +                       shift *= (controller->bytes_per_word - idx - 1);
> > +                       rx_buf[controller->rx_bytes] = word >> shift;
> > +               }
> > +       }
> > +}

<snip>

> > +static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
> > +{
> > +       struct spi_qup *controller = dev_id;
> > +       struct spi_transfer *xfer;
> > +       u32 opflags, qup_err, spi_err;
> > +
> > +       xfer = controller->xfer;
> > +
> > +       qup_err = readl_relaxed(controller->base + QUP_ERROR_FLAGS);
> > +       spi_err = readl_relaxed(controller->base + SPI_ERROR_FLAGS);
> > +       opflags = readl_relaxed(controller->base + QUP_OPERATIONAL);
> > +
> > +       writel_relaxed(qup_err, controller->base + QUP_ERROR_FLAGS);
> > +       writel_relaxed(spi_err, controller->base + SPI_ERROR_FLAGS);
> > +       writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
> > +
> > +       if (!xfer)
> > +               return IRQ_HANDLED;
> > +
> > +       if (qup_err) {
> > +               if (qup_err & QUP_ERROR_OUTPUT_OVER_RUN)
> > +                       dev_warn(controller->dev, "OUTPUT_OVER_RUN\n");
> > +               if (qup_err & QUP_ERROR_INPUT_UNDER_RUN)
> > +                       dev_warn(controller->dev, "INPUT_UNDER_RUN\n");
> > +               if (qup_err & QUP_ERROR_OUTPUT_UNDER_RUN)
> > +                       dev_warn(controller->dev, "OUTPUT_UNDER_RUN\n");
> > +               if (qup_err & QUP_ERROR_INPUT_OVER_RUN)
> > +                       dev_warn(controller->dev, "INPUT_OVER_RUN\n");
> > +
> > +               controller->error = -EIO;
> > +       }
> > +
> > +       if (spi_err) {
> > +               if (spi_err & SPI_ERROR_CLK_OVER_RUN)
> > +                       dev_warn(controller->dev, "CLK_OVER_RUN\n");
> > +               if (spi_err & SPI_ERROR_CLK_UNDER_RUN)
> > +                       dev_warn(controller->dev, "CLK_UNDER_RUN\n");
> > +
> > +               controller->error = -EIO;
> > +       }
> > +
> > +       if (opflags & QUP_OP_IN_SERVICE_FLAG) {
> > +               writel_relaxed(QUP_OP_IN_SERVICE_FLAG,
> > +                      controller->base + QUP_OPERATIONAL);
> Write is not necessary since already cleared above.
> > +               spi_qup_fifo_read(controller, xfer);
> > +       }
> > +
> > +       if (opflags & QUP_OP_OUT_SERVICE_FLAG) {
> > +               writel_relaxed(QUP_OP_OUT_SERVICE_FLAG,
> > +                      controller->base + QUP_OPERATIONAL);
> Write is not necessary since already cleared above.

True. I have forgot to remove these writes. Will fix.

Regards,
Ivan

> > +               spi_qup_fifo_write(controller, xfer);
> > +       }
> > +
> > +       if (controller->rx_bytes == xfer->len ||
> > +           controller->error)
> > +               complete(&controller->done);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
