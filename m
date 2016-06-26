From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] drivers core: allow id match override when manually
 binding driver
Date: Sun, 26 Jun 2016 21:07:08 +0200
Message-ID: <CAOMqctSJjvyknkTjHZbfbt8nh0Eo_oc9LTonjZGUmwP5b8gWDg@mail.gmail.com>
References: <cover.1466696079.git.hramrach@gmail.com> <5e0397742f887f656d67bb0d61c8e10782c0e5af.1466696079.git.hramrach@gmail.com>
 <20160626182811.GA20461@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>,
	Davidlohr Bueso <dave-h16yJtLeMjHk1uMJSBkQmQ@public.gmane.org>,
	Andrey Ryabinin <aryabinin-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>,
	Nikolay Aleksandrov <nikolay-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>,
	Dmitry Vyukov <dvyukov-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Adrien Schildknecht <adrien+dev-Yk6CzqVXkG6lnMjI0IkVqw@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160626182811.GA20461-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 26 June 2016 at 20:28, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> On Thu, Jun 23, 2016 at 05:41:20PM -0000, Michal Suchanek wrote:
>> This allows binding spidev on any slave device by hand using sysfs
>> without adding superfluous compatibles or any other needless
>> complication.
>>
>> Note that any slave driver that requires configuration will fail to
>> probe anyway. Only a driver that binds to anything can be bound
>> successfully.
>>
>> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/base/Kconfig.debug | 14 +++++++++
>>  drivers/base/bus.c         | 72 +++++++++++++++++++++++++++++++++++++++++++++-
>>  lib/Kconfig.debug          |  2 ++
>>  3 files changed, 87 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/base/Kconfig.debug
>>
>> diff --git a/drivers/base/Kconfig.debug b/drivers/base/Kconfig.debug
>> new file mode 100644
>> index 0000000..e21d3cc
>> --- /dev/null
>> +++ b/drivers/base/Kconfig.debug
>> @@ -0,0 +1,14 @@
>> +menuconfig DRIVER_MATCH_OVERRIDE
>> +     bool "Allow manual driver binding to override id match (DANGEROUS)"
>> +     default n
>> +     help
>> +       When binding a driver manually bypass the check of driver id table
>> +       against device id in driver core. This can be useful for development
>> +       or on buses that don't provide reliable device identification.
>
> Ick, no no no.  Why would you ever want to let this happen?  If you
> really want to override the check, just write things to the 'bind' file
> in sysfs, that will skip the driver id check entirely, right?

Well, it does not. Hence this patch which enables skipping the check.
It's the whole point of it.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
