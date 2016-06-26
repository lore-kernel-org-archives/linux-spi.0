From: Michal Suchanek <hramrach@gmail.com>
Subject: Re: [PATCH 2/3] spi: of: allow instantiating slaves without a driver
Date: Sun, 26 Jun 2016 14:53:31 +0200
Message-ID: <CAOMqctRrz7KZ0RFFnE4kW=Kst9ha6QAj2ZVkirSjuDXpZHqSDg@mail.gmail.com>
References: <cover.1466696079.git.hramrach@gmail.com> <ebe2a48124441819adab773b28cd12425ba5bda4.1466696079.git.hramrach@gmail.com>
 <20160626011500.GF28202@sirena.org.uk> <CAOMqctSA0G+fBKNgAizqWvEUfJLr9Fh0SsN0Pn-cQv=zeu7iFg@mail.gmail.com>
 <20160626112133.GJ28202@sirena.org.uk> <CAOMqctQernycZkc0Wia9EierT1PhfcYAPWc=89LgTC-DBgkg5A@mail.gmail.com>
 <20160626115815.GN28202@sirena.org.uk> <CAOMqctTf16DDs1j+pL47xBJt2BVdCdHPFUEwaZ6ak_vFtrKBOQ@mail.gmail.com>
 <20160626124550.GO28202@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Tejun Heo <tj@kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Adrien Schildknecht <adrien+dev@schischi.me>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160626124550.GO28202@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 26 June 2016 at 14:45, Mark Brown <broonie@kernel.org> wrote:
> On Sun, Jun 26, 2016 at 02:39:20PM +0200, Michal Suchanek wrote:
>> On 26 June 2016 at 13:58, Mark Brown <broonie@kernel.org> wrote:
>
>> > No, there's a lot more to having overlays to board-neutral connectors...
>
>> If you are fine with using only the SPI pins then this is all it takes.
>
> No, there's other things like figuring out which controller to bind to
> that need to be taken into consideration.

Why do you care? So long as you name the CS that is available on
connector with the same pinout same on all boards you can target the
slave regardless of the controller it's attached to.

Thanks

Michal
