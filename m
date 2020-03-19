From: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH V2 4/8] tty: serial: qcom_geni_serial: Add interconnect
 support
Date: Thu, 19 Mar 2020 13:42:48 -0700
Message-ID: <20200319204248.GA204494@google.com>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-5-git-send-email-akashast@codeaurora.org>
 <20200313212833.GK144492@google.com>
 <e9293de6-004f-6005-8cb6-66f28c080ebe@codeaurora.org>
 <20200317190804.GS144492@google.com>
 <e95bd6e0-d1fd-9d13-47df-f7d08b443e37@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
To: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e95bd6e0-d1fd-9d13-47df-f7d08b443e37-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Mar 18, 2020 at 05:53:22PM +0530, Akash Asthana wrote:
> Hi Matthias,
> 
> On 3/18/2020 12:38 AM, Matthias Kaehlcke wrote:
> > On Tue, Mar 17, 2020 at 05:18:34PM +0530, Akash Asthana wrote:
> > > Hi Matthias,
> > > 
> > > On 3/14/2020 2:58 AM, Matthias Kaehlcke wrote:
> > > > Hi Akash,
> > > > 
> > > > On Fri, Mar 13, 2020 at 06:42:10PM +0530, Akash Asthana wrote:
> > > > > Get the interconnect paths for Uart based Serial Engine device
> > > > > and vote according to the baud rate requirement of the driver.
> > > > > 
> > > > > Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > > > > ---
> > > > > Changes in V2:
> > > > >    - As per Bjorn's comment, removed se == NULL check from geni_serial_icc_get
> > > > >    - As per Bjorn's comment, removed code to set se->icc_path* to NULL in failure
> > > > >    - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
> > > > >      path handle
> > > > >    - As per Matthias comment, added error handling for icc_set_bw call
> > > > > 
> > > > >    drivers/tty/serial/qcom_geni_serial.c | 69 +++++++++++++++++++++++++++++++++--
> > > > >    1 file changed, 65 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> > > > > index 272bae0..c8ad7e9 100644
> > > > > --- a/drivers/tty/serial/qcom_geni_serial.c
> > > > > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > > > > 
> > > > > ...
> > > > > 
> > > > >    static int qcom_geni_serial_request_port(struct uart_port *uport)
> > > > >    {
> > > > >    	struct platform_device *pdev = to_platform_device(uport->dev);
> > > > > @@ -962,6 +975,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
> > > > >    	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> > > > >    	unsigned long clk_rate;
> > > > >    	u32 ver, sampling_rate;
> > > > > +	int ret;
> > > > >    	qcom_geni_serial_stop_rx(uport);
> > > > >    	/* baud rate */
> > > > > @@ -983,6 +997,18 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
> > > > >    	ser_clk_cfg = SER_CLK_EN;
> > > > >    	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
> > > > > +	/*
> > > > > +	 * Put BW vote only on CPU path as driver supports FIFO mode only.
> > > > > +	 * Assume peak_bw as twice of avg_bw.
> > > > > +	 */
> > > > > +	port->se.avg_bw_cpu = Bps_to_icc(baud);
> > > > > +	port->se.peak_bw_cpu = Bps_to_icc(2 * baud);
> > > > > +	ret = icc_set_bw(port->se.icc_path_cpu_to_geni, port->se.avg_bw_cpu,
> > > > > +			port->se.peak_bw_cpu);
> > > > > +	if (ret)
> > > > > +		dev_err(uport->dev, "%s: ICC BW voting failed for cpu\n",
> > > > > +			__func__);
> > > > Should this return an error? The port might not operate properly if the ICC
> > > > bandwidth couldn't be configured
> > > This is void function we can't return error from here. I guess it would be
> > > somewhat okay if BW voting failed for CPU path but clk_set_rate failure is
> > > more serious which is called from this function, I don't think it can be
> > > move to somewhere else.
> > ok, I missed that _set_termios() is void.
> > 
> > > > >    static const struct uart_ops qcom_geni_console_pops = {
> > > > > @@ -1308,6 +1358,17 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
> > > > >    	port->rx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
> > > > >    	port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
> > > > > +	ret = geni_serial_icc_get(&port->se);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +	/* Set the bus quota to a reasonable value */
> > > > > +	port->se.avg_bw_core = console ? Bps_to_icc(1000) :
> > > > > +		Bps_to_icc(CORE_2X_50_MHZ);
> > > > Why different settings for console vs. non-console?
> > > QUP FW runs on core clock. To support higher throughput we want FW to run at
> > > higher speed.
> > > 
> > > Since Console operate at 115200bps and BT operate at 3.2Mbps baud. We are
> > > voting higher on core for BT usecase.
> > > 
> > > These value are recommended from HW team.
> > IIUC none of the values you mention are set in stone. 115200bps seems to be a
> > 'standard' value for the serial console, but it could be a different baudrate.
> > I guess you are referring to Qualcomm Bluetooth controllers, which are only one
> > of many things that could be connected to the port. And what happens when a
> > QCA BT controller is connected to a non-geni/QCA port, which doesn't know about
> > its 'requirements'? The answer is that both the BT controller and the serial
> > console configure the baudrate they need, hence using different values in
> > _probe() is pointless.
> 
> Are you refering other UART drivers(not based on geni HW) as non-geni/QCA
> port?
> 
> We are not scaling core BW request based on real time need like we are doing
> for other paths(CPU/DDR) instead we are using some fail proof value because,
> FW runs on core clock and core behaves a bit different than other NOCs.
>
> We don't have any functional relation which maps actual throughput
> requirement to core frequency need. In the past we faced few latency issues
> because of core slowness (Although it was running much higher than actual
> throughput requirement). To avoid such scenario we are using recommend value
> from HW team. These fix value can support SE drivers operating at their max
> possible speed(4Mbps in case of non-console).

ok, I missed that the core clocks aren't scaled based on the configured
baudrate. Apparently experience shows that it is not practical due to the
latency issues you mention.

> I agree that 115200bps seems to be a 'standard' value for the serial
> console, but it could be a different baudrate.
> 
> We are voting 1000 in case of console because it  has low power mode
> use-case in android, where voting CORE_2X_50_MHZ can be reported as a power
> issue.
> 
> Actually we wanted to vote 960 for console but that is not possible with
> current ICC design where the minimum value is 1000bps.  So any way core is
> running at 50 MHz as 1000 crosses the threshold for 19.2 MHz (960)
> 
> only with console.

Thanks for the clarification. So if a board wanted to use a higher baudrate
for the console it (currently) shouldn't be a problem. While it would be nice
to have uniform settings for all UARTs it's also not a big deal to have two
values, just wanted to make sure it's needed
