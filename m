From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH 2/2] spi: qup: Request CS GPIO's during probe
Date: Tue, 10 Mar 2015 10:10:56 +0200
Message-ID: <1425975056.2440.24.camel@mm-sol.com>
References: <1425655578-22400-1-git-send-email-iivanov@mm-sol.com>
	 <1425655578-22400-2-git-send-email-iivanov@mm-sol.com>
	 <20150307105948.GD28806@sirena.org.uk>
	 <1425889415.2440.10.camel@mm-sol.com>
	 <20150309182841.GW28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150309182841.GW28806@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On Mon, 2015-03-09 at 18:28 +0000, Mark Brown wrote:
> On Mon, Mar 09, 2015 at 10:23:35AM +0200, Ivan T. Ivanov wrote:
> > Hi,
> 
> Don't reply off list unless there's a good reason...

Sorry, it was not intentional. Wrong button.

> 
> > > Any new GPIO users should really be using the gpiod API, however this is
> > > duplicating core functionality so as Stephen says why are we doing this?
> 
> > About the API usage, point taken. GPIO requesting part is more important
> > in this case. pinctrl core did not request pins and wrong DT configuration
> > could lead to surprises without any warnings or errors.
> 
> That doesn't answer my concern at all.

I am not sure that I am following you. 

I can not use spi_master::cs_gpios, which is populated by 
of_spi_register_master(), because spi_register_master() 
populate SPI devices and they could issue setup method.

Requesting GPIO's in core framework is also not a easy
option because of arguments here[1].

Probably I am still missing something.

Regards,
Ivan

[1] https://lkml.org/lkml/2014/5/24/75
