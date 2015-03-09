From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [RFC PATCH] spi: Ensure that CS line is in non-active state
 after setup
Date: Mon, 09 Mar 2015 09:11:36 +0200
Message-ID: <1425885096.2440.6.camel@mm-sol.com>
References: <1425656716-25363-1-git-send-email-iivanov@mm-sol.com>
	 <20150308200142.GC28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150308200142.GC28806@sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On Sun, 2015-03-08 at 20:01 +0000, Mark Brown wrote:
> On Fri, Mar 06, 2015 at 05:45:15PM +0200, Ivan T. Ivanov wrote:
> 
> >         if (spi->master->setup)
> >                 status = spi->master->setup(spi);
> > +       else
> > +               spi_set_cs(spi, false);
> 
> Why would this be conditional on there not being a setup operation?
> It's a good idea, I just don't see why the backstop isn't always useful.

I was thinking that this is expected to be handled inside
setup operation, nothing more.

Ivan 
