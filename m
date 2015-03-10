From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH 2/2] spi: qup: Request CS GPIO's during probe
Date: Tue, 10 Mar 2015 14:53:17 +0200
Message-ID: <1425991997.12581.1.camel@mm-sol.com>
References: <1425655578-22400-1-git-send-email-iivanov@mm-sol.com>
	 <1425655578-22400-2-git-send-email-iivanov@mm-sol.com>
	 <20150307105948.GD28806@sirena.org.uk>
	 <1425889415.2440.10.camel@mm-sol.com>
	 <20150309182841.GW28806@sirena.org.uk>
	 <1425975056.2440.24.camel@mm-sol.com>
	 <20150310110638.GD28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150310110638.GD28806@sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On Tue, 2015-03-10 at 11:06 +0000, Mark Brown wrote:
> On Tue, Mar 10, 2015 at 10:10:56AM +0200, Ivan T. Ivanov wrote:
> > On Mon, 2015-03-09 at 18:28 +0000, Mark Brown wrote:
> 
> > > > About the API usage, point taken. GPIO requesting part is more important
> > > > in this case. pinctrl core did not request pins and wrong DT configuration
> > > > could lead to surprises without any warnings or errors.
> 
> > > That doesn't answer my concern at all.
> 
> > I am not sure that I am following you.
> 
> > I can not use spi_master::cs_gpios, which is populated by
> > of_spi_register_master(), because spi_register_master()
> > populate SPI devices and they could issue setup method.
> 
> I'm sorry but I can't parse the above.  What does "they could issue
> setup method" mean and why is it a problem?

Client drivers could execute spi_setup() in probe(), so we have
to ensure that CS GPIO's are available before this, no?

> 
> > Requesting GPIO's in core framework is also not a easy
> > option because of arguments here[1].
> 
> We should really fix that though.
> 

I think that pinctrl framework should automatically
request pins belonging to group when state is selected.

Regards,
Ivan
