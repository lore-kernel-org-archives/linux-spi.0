From: dsneddon@codeaurora.org
Subject: Re: Fwd: [PATCH 2/2] spi: Add Qualcomm QUP SPI controller support
Date: Mon, 10 Feb 2014 17:41:31 -0000
Message-ID: <9444e7f42975231b50bc6564192ba416.squirrel@www.codeaurora.org>
References: <1391705868-20091-1-git-send-email-iivanov@mm-sol.com>
    <1391705868-20091-3-git-send-email-iivanov@mm-sol.com>
    <CACceFXdUobQvN2hcv5kh+QL=o8bWM_PVkAtrOx+euZSeVDm8hQ@mail.gmail.com>
    <214fe9fc7e62ab30bdfbb4ac5d1ee250.squirrel@www.codeaurora.org>
    <1392047651.2853.19.camel@iivanov-dev>
    <3388d68dc907e9190d997fad95830d74.squirrel@www.codeaurora.org>
    <1392052316.2853.67.camel@iivanov-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: dsneddon@codeaurora.org, broonie@kernel.org,
	grant.likely@linaro.org, robh+dt@kernel.org,
	linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	inux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	alokc@codeaurora.org, gavidov@codeaurora.org,
	kgunda@codeaurora.org, sdharia@codeaurora.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1392052316.2853.67.camel@iivanov-dev>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Ivan,

>> >> > +static int spi_qup_set_state(struct spi_qup *controller, u32
>> state)
>> >> > +{
>> >> > +       unsigned long loop = 0;
>> >> > +       u32 cur_state;
>> >> > +
>> >> > +       cur_state = readl_relaxed(controller->base + QUP_STATE);
>> >> Make sure the state is valid before you read the current state.
>> >
>> > Why? Controller is always left in valid state (after probe and every
>> > transaction)? I know that CAF code contain this check, but now driver
>> > is little bit different. I have made some tests and controller is
>> > always in valid state in this point.
>>
>> The hardware programming guide we recommends doing this.  I'd have to
>> talk
>> to the hardware designers to know exactly the reason why.  I can follow
>> up
>> on this if you'd like.
>>
>
> Ok, thanks. I could add it back. Please, could you point me to place
> in driver where this could happen.
>
>
>> >
>> >> > +       /*
>> >> > +        * Per spec: for PAUSE_STATE to RESET_STATE, two writes
>> >> > +        * of (b10) are required
>> >> > +        */
>> >> > +       if (((cur_state & QUP_STATE_MASK) == QUP_STATE_PAUSE) &&
>> >> > +           (state == QUP_STATE_RESET)) {
>> >> > +               writel_relaxed(QUP_STATE_CLEAR, controller->base +
>> >> > QUP_STATE);
>> >> > +               writel_relaxed(QUP_STATE_CLEAR, controller->base +
>> >> > QUP_STATE);
>> >> > +       } else {
>> >> Make sure you don't transition from RESET to PAUSE.
>> >
>> > I don't see this to be handled in CAF code. Could you give me
>> > more details, please?
>> >
>> > Right now possible state transactions are:
>> >
>> > * if everything is fine:
>> >   RESET -> RUN -> PAUSE -> RUN -> RESET
>> > * in case of error:
>> >   RESET -> RUN -> RESET
>> >   RESET -> RUN -> PAUSE -> RESET
>> >
>> > Please correct me if I am wrong.
>>
>> According to the hardware documentation if the hardware is in the RESET
>> state and we try to transition to the PAUSE state the hardware behavior
>> is
>> "undefined", which usually means bad things will happen.  Admittedly, if
>> the driver always follows the "valid" rules (the ones you've listed
>> above)
>> it _should_ never happen.  However, it is _possible_ the hardware is in
>> the RESET state while the driver thinks it's in the RUN state and the
>> driver tries to put is in the PAUSE state.  In other words, I'd like to
>> err on the side of caution since the check doesn't really cost us
>> anything.
>
> Ok that is fine, but did you see where/how this could happen in
> the current implementation. If this could happen I will like to fix it.

I don't see a problem in the current implementation that would cause you
to get in the RESET state without knowing it.  It's just my paranoia
kicking in.

>
>>
>> >
>> >> > +
>> >> > +static void spi_qup_fifo_read(struct spi_qup *controller,
>> >> > +                             struct spi_transfer *xfer)
>> >> > +{
>> >> > +       u8 *rx_buf = xfer->rx_buf;
>> >> > +       u32 word, state;
>> >> > +       int idx, shift;
>> >> > +
>> >> > +       while (controller->rx_bytes < xfer->len) {
>> >> > +
>> >> > +               state = readl_relaxed(controller->base +
>> >> QUP_OPERATIONAL);
>> >> > +               if (0 == (state & QUP_OP_IN_FIFO_NOT_EMPTY))
>> >> > +                       break;
>> >> > +
>> >> > +               word = readl_relaxed(controller->base +
>> >> QUP_INPUT_FIFO);
>> >> > +
>> >> > +               for (idx = 0; idx < controller->bytes_per_word &&
>> >> > +                    controller->rx_bytes < xfer->len; idx++,
>> >> > +                    controller->rx_bytes++) {
>> >> > +
>> >> > +                       if (!rx_buf)
>> >> > +                               continue;
>> >> If there is no rx_buf just set rx_bytes to xfer->len and skip the
>> loop
>> >> entirely.
>> >
>> > Well, FIFO buffer still should be drained, right?
>> > Anyway. I am looking for better way to handle this.
>> > Same applies for filling FIFO buffer.
>> >
>>
>> Yes.  Still read from the FIFO but skip the for loop since we're just
>> adding bytes_per_word to the total rx_byte count one iteration at a time
>> and not doing anything with the data.
>>
>
> My point was: If I made rx_bytes equal xfer->len, outer while loop will
> be terminated before FIFO was drained :-). I will see how to handle
> this better.

You're right!  Had to read that snippet again.  Though, I think we can
skip draining the FIFO by setting the NO_INPUT bit in the QUP_CONFIG
register (and the NO_OUTPUT for writes).
