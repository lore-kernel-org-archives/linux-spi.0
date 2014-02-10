From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: Fwd: [PATCH 2/2] spi: Add Qualcomm QUP SPI controller support
Date: Mon, 10 Feb 2014 19:11:56 +0200
Message-ID: <1392052316.2853.67.camel@iivanov-dev>
References: <1391705868-20091-1-git-send-email-iivanov@mm-sol.com>
	 <1391705868-20091-3-git-send-email-iivanov@mm-sol.com>
	 <CACceFXdUobQvN2hcv5kh+QL=o8bWM_PVkAtrOx+euZSeVDm8hQ@mail.gmail.com>
	 <214fe9fc7e62ab30bdfbb4ac5d1ee250.squirrel@www.codeaurora.org>
	 <1392047651.2853.19.camel@iivanov-dev>
	 <3388d68dc907e9190d997fad95830d74.squirrel@www.codeaurora.org>
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
In-Reply-To: <3388d68dc907e9190d997fad95830d74.squirrel-mMfbam+mt9083fI46fginR2eb7JE58TQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Hi Dan, 

On Mon, 2014-02-10 at 16:21 +0000, dsneddon-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org wrote: 
> Hi Ivan,
> >
> >> > +
> >> > +static int spi_qup_set_state(struct spi_qup *controller, u32 state)
> >> > +{
> >> > +       unsigned long loop = 0;
> >> > +       u32 cur_state;
> >> > +
> >> > +       cur_state = readl_relaxed(controller->base + QUP_STATE);
> >> Make sure the state is valid before you read the current state.
> >
> > Why? Controller is always left in valid state (after probe and every
> > transaction)? I know that CAF code contain this check, but now driver
> > is little bit different. I have made some tests and controller is
> > always in valid state in this point.
> 
> The hardware programming guide we recommends doing this.  I'd have to talk
> to the hardware designers to know exactly the reason why.  I can follow up
> on this if you'd like.
> 

Ok, thanks. I could add it back. Please, could you point me to place
in driver where this could happen.


> >
> >> > +       /*
> >> > +        * Per spec: for PAUSE_STATE to RESET_STATE, two writes
> >> > +        * of (b10) are required
> >> > +        */
> >> > +       if (((cur_state & QUP_STATE_MASK) == QUP_STATE_PAUSE) &&
> >> > +           (state == QUP_STATE_RESET)) {
> >> > +               writel_relaxed(QUP_STATE_CLEAR, controller->base +
> >> > QUP_STATE);
> >> > +               writel_relaxed(QUP_STATE_CLEAR, controller->base +
> >> > QUP_STATE);
> >> > +       } else {
> >> Make sure you don't transition from RESET to PAUSE.
> >
> > I don't see this to be handled in CAF code. Could you give me
> > more details, please?
> >
> > Right now possible state transactions are:
> >
> > * if everything is fine:
> >   RESET -> RUN -> PAUSE -> RUN -> RESET
> > * in case of error:
> >   RESET -> RUN -> RESET
> >   RESET -> RUN -> PAUSE -> RESET
> >
> > Please correct me if I am wrong.
> 
> According to the hardware documentation if the hardware is in the RESET
> state and we try to transition to the PAUSE state the hardware behavior is
> "undefined", which usually means bad things will happen.  Admittedly, if
> the driver always follows the "valid" rules (the ones you've listed above)
> it _should_ never happen.  However, it is _possible_ the hardware is in
> the RESET state while the driver thinks it's in the RUN state and the
> driver tries to put is in the PAUSE state.  In other words, I'd like to
> err on the side of caution since the check doesn't really cost us
> anything.

Ok that is fine, but did you see where/how this could happen in
the current implementation. If this could happen I will like to fix it.

> 
> >
> >> > +
> >> > +static void spi_qup_fifo_read(struct spi_qup *controller,
> >> > +                             struct spi_transfer *xfer)
> >> > +{
> >> > +       u8 *rx_buf = xfer->rx_buf;
> >> > +       u32 word, state;
> >> > +       int idx, shift;
> >> > +
> >> > +       while (controller->rx_bytes < xfer->len) {
> >> > +
> >> > +               state = readl_relaxed(controller->base +
> >> QUP_OPERATIONAL);
> >> > +               if (0 == (state & QUP_OP_IN_FIFO_NOT_EMPTY))
> >> > +                       break;
> >> > +
> >> > +               word = readl_relaxed(controller->base +
> >> QUP_INPUT_FIFO);
> >> > +
> >> > +               for (idx = 0; idx < controller->bytes_per_word &&
> >> > +                    controller->rx_bytes < xfer->len; idx++,
> >> > +                    controller->rx_bytes++) {
> >> > +
> >> > +                       if (!rx_buf)
> >> > +                               continue;
> >> If there is no rx_buf just set rx_bytes to xfer->len and skip the loop
> >> entirely.
> >
> > Well, FIFO buffer still should be drained, right?
> > Anyway. I am looking for better way to handle this.
> > Same applies for filling FIFO buffer.
> >
> 
> Yes.  Still read from the FIFO but skip the for loop since we're just
> adding bytes_per_word to the total rx_byte count one iteration at a time
> and not doing anything with the data.
> 

My point was: If I made rx_bytes equal xfer->len, outer while loop will
be terminated before FIFO was drained :-). I will see how to handle
this better.

Thanks,
Ivan

> Thanks,
> Dan
> 
> 


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
