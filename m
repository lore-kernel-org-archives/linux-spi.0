From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 3/6] i2c: i2c-qcom-geni: Add interconnect support
Date: Thu, 20 Feb 2020 16:24:00 -0800
Message-ID: <20200221002400.GD24720@google.com>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-4-git-send-email-akashast@codeaurora.org>
 <20200218224709.GF15781@google.com>
 <84a7d97a-4e10-5509-9c87-af8a545c7385@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org
To: Akash Asthana <akashast@codeaurora.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <84a7d97a-4e10-5509-9c87-af8a545c7385@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Akash,

On Wed, Feb 19, 2020 at 07:17:44PM +0530, Akash Asthana wrote:
> Hi Matthias,
> 
> On 2/19/2020 4:17 AM, Matthias Kaehlcke wrote:
> > On Mon, Feb 17, 2020 at 07:00:02PM +0530, Akash Asthana wrote:
> > > Get the interconnect paths for I2C based Serial Engine device
> > > and vote according to the bus speed of the driver.
> > > 
> > > Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> > > ---
> > >   drivers/i2c/busses/i2c-qcom-geni.c | 84 ++++++++++++++++++++++++++++++++++++--
> > >   1 file changed, 80 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> > > index 17abf60c..5de10a1 100644
> > > --- a/drivers/i2c/busses/i2c-qcom-geni.c
> > > +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> > >
> > >   static void geni_i2c_err_misc(struct geni_i2c_dev *gi2c)
> > >   {
> > >   	u32 m_cmd = readl_relaxed(gi2c->se.base + SE_GENI_M_CMD0);
> > > @@ -563,17 +601,34 @@ static int geni_i2c_probe(struct platform_device *pdev)
> > >   	gi2c->adap.dev.of_node = pdev->dev.of_node;
> > >   	strlcpy(gi2c->adap.name, "Geni-I2C", sizeof(gi2c->adap.name));
> > > +	ret = geni_i2c_icc_get(&gi2c->se);
> > > +	if (ret)
> > > +		return ret;
> > > +	/* Set the bus quota to a reasonable value */
> > > +	gi2c->se.avg_bw_core = Bps_to_icc(1000);
> > > +	gi2c->se.peak_bw_core = Bps_to_icc(CORE_2X_100_MHZ);
> > > +	gi2c->se.avg_bw_cpu = Bps_to_icc(1000);
> > > +	gi2c->se.peak_bw_cpu = Bps_to_icc(1000);
> > > +	gi2c->se.avg_bw_ddr = Bps_to_icc(gi2c->clk_freq_out);
> > > +	gi2c->se.peak_bw_ddr = Bps_to_icc(2 * gi2c->clk_freq_out);
> > > +
> > > +	/* Vote for core clocks and CPU for register access */
> > > +	icc_set_bw(gi2c->se.icc_path[GENI_TO_CORE], gi2c->se.avg_bw_core,
> > > +				gi2c->se.peak_bw_core);
> > > +	icc_set_bw(gi2c->se.icc_path[CPU_TO_GENI], gi2c->se.avg_bw_cpu,
> > > +				gi2c->se.peak_bw_cpu);
> > error handling needed?
> 
> I will add error handling for GENI_TO_CORE path in all the drivers. Will it
> be okay if we don't handle errors for CPU_TO_GENI and GENI_TO_DDR path
> 
> as CPU and DDR will be running at much higher frequency?

It may still work, but you might never know that there was a problem. I
would be inclined to check the return value of all invocations of icc_set_bw()
- including runtime suspend/resume - and log a message if a problem is
detected. For runtime suspend/resume it would probably be wise to use
dev_err_ratelimited(), to avoid spamming the system log too much in case of
a persistent problem.

If others think that error checking all icc_set_bw() calls is overkill
please speak up :)

Thanks

Matthias
