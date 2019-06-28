From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 3/5] docs: i2c: convert to ReST and add to driver-api
 bookset
Date: Fri, 28 Jun 2019 23:41:38 +0200
Message-ID: <20190628214138.GU3692@piout.net>
References: <cover.1561756511.git.mchehab+samsung@kernel.org>
 <3997b54a2e73887b96ec665573f08ded78b71421.1561756511.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andreas Werner <andreas.werner@men.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rudolf Marek <r.marek@assembler.cz>,
        Seth Heasley <seth.heasley@intel.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Ajay Gupta <ajayg@nvidia.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Jim Cromie <jim.cromie@gmail.com>,
        Mark Bro
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3997b54a2e73887b96ec665573f08ded78b71421.1561756511.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 28/06/2019 18:23:14-0300, Mauro Carvalho Chehab wrote:
> diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
> index 225a8df1d4e9..1803f3cab39f 100644
> --- a/drivers/rtc/rtc-ds1374.c
> +++ b/drivers/rtc/rtc-ds1374.c
> @@ -14,7 +14,7 @@
>   */
>  /*
>   * It would be more efficient to use i2c msgs/i2c_transfer directly but, as
> - * recommened in .../Documentation/i2c/writing-clients section
> + * recommened in .../Documentation/i2c/writing-clients.rst section
>   * "Sending and receiving", using SMBus level communication is preferred.
>   */
>  

Honestly, the whole comment could be removed. The current trend is to
move everything to regmap anyway.

However, I'm fine with that change if you want to keep it that way (and
probably scripted).

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
