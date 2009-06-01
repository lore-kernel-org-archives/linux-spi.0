From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [spi-devel-general] [PATCH] ARM PL022 SSP/SPI driver v1
Date: Mon, 1 Jun 2009 08:35:55 +0100
Message-ID: <20090601073555.GA10590@n2100.arm.linux.org.uk>
References: <63386a3d0905271519x1afc6c4bo8d40315e2e387b63@mail.gmail.com>
	<20090601041711.GE14148@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.ml.walleij@gmail.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.arm.linux.org.uk,
	David Brownell <dbrownell@users.sourceforge.net>,
	Linus Walleij <linus.walleij@stericsson.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Alessandro Rubini <rubini-list@gnudd.com>, sachin.verma@st.com,
	andrea.gallo@stericsson.com, STEricsson_nomadik_linux@list.st.com
To: Baruch Siach <baruch@tkos.co.il>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20090601041711.GE14148@tarshish>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
List-Id: linux-spi.vger.kernel.org

On Mon, Jun 01, 2009 at 07:31:01AM +0300, Baruch Siach wrote:
> Why include/linux/amba/? There's nothing AMBA specific in this header. IMO 
> include/linux/spi is a better place for this header.

Because that's where AMBA primecell headers go.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
