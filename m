From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC PATCH] spi: Ensure that CS line is in non-active state after setup
Date: Mon, 9 Mar 2015 14:11:45 +0200
Message-ID: <CAHp75VcVqbiYWvBkcZrp7wwVjjfNO_S75am=9KCJ_cOWja5BJw@mail.gmail.com>
References: <1425656716-25363-1-git-send-email-iivanov@mm-sol.com>
	<20150308200142.GC28806@sirena.org.uk>
	<1425885096.2440.6.camel@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-arm-msm@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425885096.2440.6.camel@mm-sol.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Mar 9, 2015 at 9:11 AM, Ivan T. Ivanov <iivanov@mm-sol.com> wrote:
>
> On Sun, 2015-03-08 at 20:01 +0000, Mark Brown wrote:
>> On Fri, Mar 06, 2015 at 05:45:15PM +0200, Ivan T. Ivanov wrote:
>>
>> >         if (spi->master->setup)
>> >                 status = spi->master->setup(spi);
>> > +       else
>> > +               spi_set_cs(spi, false);
>>
>> Why would this be conditional on there not being a setup operation?
>> It's a good idea, I just don't see why the backstop isn't always useful.
>
> I was thinking that this is expected to be handled inside
> setup operation, nothing more.

Agree with Mark. It's perhaps a good idea to call unconditionally
before ->setup().


-- 
With Best Regards,
Andy Shevchenko
