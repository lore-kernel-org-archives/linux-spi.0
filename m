From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: of: allow instantiating slaves without a driver
Date: Sun, 26 Jun 2016 17:19:54 +0200
Message-ID: <CAOMqctQpr4A6_bS_+G9DQdcxcYkPHxntX_vUPBCoZN8FxHOxzg@mail.gmail.com>
References: <cover.1466696079.git.hramrach@gmail.com> <ebe2a48124441819adab773b28cd12425ba5bda4.1466696079.git.hramrach@gmail.com>
 <20160626011500.GF28202@sirena.org.uk> <CAOMqctSA0G+fBKNgAizqWvEUfJLr9Fh0SsN0Pn-cQv=zeu7iFg@mail.gmail.com>
 <20160626112133.GJ28202@sirena.org.uk> <CAOMqctQernycZkc0Wia9EierT1PhfcYAPWc=89LgTC-DBgkg5A@mail.gmail.com>
 <20160626115815.GN28202@sirena.org.uk> <CAOMqctTf16DDs1j+pL47xBJt2BVdCdHPFUEwaZ6ak_vFtrKBOQ@mail.gmail.com>
 <20160626124550.GO28202@sirena.org.uk> <CAOMqctRrz7KZ0RFFnE4kW=Kst9ha6QAj2ZVkirSjuDXpZHqSDg@mail.gmail.com>
 <20160626125717.GQ28202@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
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
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160626125717.GQ28202-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 26 June 2016 at 14:57, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Sun, Jun 26, 2016 at 02:53:31PM +0200, Michal Suchanek wrote:
>> On 26 June 2016 at 14:45, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
>> > No, there's other things like figuring out which controller to bind to
>> > that need to be taken into consideration.
>
>> Why do you care? So long as you name the CS that is available on
>> connector with the same pinout same on all boards you can target the
>> slave regardless of the controller it's attached to.
>
> That would be a binding for the connector which is the big missing bit
> here - it's not clear that such a limited connector description would be
> a good idea.

It would work for a limited number of devices. Anyway, connectors are
supposed to be transparent so if binding devices has issues now it
will supposedly have same issues once connectors allow renaming
several devices at once from board-specific name to connector-specific
name rather than one at a time as this limited connector binding
allows.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
