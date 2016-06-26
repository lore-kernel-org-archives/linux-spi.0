From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/3] drivers core: allow id match override when manually
 binding driver
Date: Sat, 25 Jun 2016 21:14:35 -0700
Message-ID: <CAPcyv4jxU2oBTk-MzH7fepu0zXnTZsAdLbY8eOvpOvZOq_QaRw@mail.gmail.com>
References: <cover.1466696079.git.hramrach@gmail.com> <5e0397742f887f656d67bb0d61c8e10782c0e5af.1466696079.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tejun Heo <tj@kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Adrien Schildknecht <adrien+dev@schischi.me>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-spi@vger.kernel.org
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5e0397742f887f656d67bb0d61c8e10782c0e5af.1466696079.git.hramrach@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jun 23, 2016 at 10:41 AM, Michal Suchanek <hramrach@gmail.com> wrote:
> This allows binding spidev on any slave device by hand using sysfs
> without adding superfluous compatibles or any other needless
> complication.
>
> Note that any slave driver that requires configuration will fail to
> probe anyway. Only a driver that binds to anything can be bound
> successfully.
>
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> ---
>  drivers/base/Kconfig.debug | 14 +++++++++
>  drivers/base/bus.c         | 72 +++++++++++++++++++++++++++++++++++++++++++++-
>  lib/Kconfig.debug          |  2 ++
>  3 files changed, 87 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/base/Kconfig.debug
>

Why change the driver core?  The matching policy can be changed with
the "match" operation of a custom "struct bus_type".
