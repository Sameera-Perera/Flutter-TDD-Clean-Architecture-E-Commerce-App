[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![LinkedIn][linkedin-shield]][linkedin-url]
<!-- PROJECT LOGO -->
<p align="center">
  <h3 align="center">Flutter TDD Clean Architecture E-Commerce App - EShop</h3>
</p>

[![Product Name Screen Shot][product-screenshot]](https://example.com)


Welcome to the Flutter-TDD-Clean-Architecture-E-Commerce-App GitHub repository! This project is a showcase of modern mobile app development practices, leveraging the power of Flutter, Test-Driven Development (TDD), Clean Architecture, and the BLoC (Business Logic Component) package. Built using the latest version of Flutter 3, this E-Commerce application exemplifies best practices for building scalable, maintainable, and efficient Flutter apps.

## Key Features:

* **Test-Driven Development (TDD)**: This project emphasizes the importance of writing tests before writing the actual code. It ensures that the application's logic is thoroughly tested, enhancing reliability and maintainability.
* **Clean Architecture**: The app follows a clean and modular architecture that separates concerns into different layers: Presentation, Domain, and Data. This architecture promotes code reusability and makes it easier to adapt to changes in the future.
* **BLoC State Management**: The app utilizes the BLoC pattern for state management. BLoC helps manage the flow of data and business logic in a clean and reactive manner, improving overall app performance.
* **E-Commerce Functionality**: The app showcases a variety of E-Commerce features, such as product browsing, searching, cart and purchasing. Users can explore products, add them to their cart, and complete transactions seamlessly.
<!-- Features -->
---
| Feature       | UseCases                                                                                                                                                                                                   |
|---------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Product       | Get Product UseCase                                                                                                                                                                                        |
| Category      | Get Cached Category UseCase<br/>Get Remote Category UseCase<br/>Filter Category UseCase                                                                                                                    |
| Cart          | Get Cached Cart UseCase<br/>Get Remote Cart UseCase<br/>Add Cart Item UseCase<br/>Sync Cart UseCase                                                                                                        |
| User          | Get Cached User UseCase<br/>SignIn UseCase<br/>SignUp UseCase<br/>SignOut UseCase                                                                                                                          |
| Delivery Info | Get Cached Delivery Info UseCase<br/>Get Remote Delivery Info UseCase<br/>Add Delivery Info UseCase<br/>Edit Delivery Info UseCase<br/>Select Delivery Info UseCase<br/>Get Selected Delivery Info UseCase |
| Order         | Get Orders UseCase<br/>Add Order UseCase                                                                                                                                                                   |

---

## Demo Sample

<div style="text-align: center">
    <table>
        <tr>
            <td style="text-align: center">
                <img src="https://res.cloudinary.com/dhyttttax/image/upload/v1695741758/RepoAssets/home-loading_r39lc6.gif" width="200"/>
            </td>            
            <td style="text-align: center">
                <img src="https://res.cloudinary.com/dhyttttax/image/upload/v1695743869/RepoAssets/home-navigation-min_q1cou5.gif" width="200"/>
            </td>
            <td style="text-align: center">
                <img src="https://res.cloudinary.com/dhyttttax/image/upload/v1695744798/RepoAssets/product-details-order_j0lvw5.gif" width="200" />
            </td>
        </tr>
        <tr>
            <td style="text-align: center">
                <img src="https://res.cloudinary.com/dhyttttax/image/upload/v1695745493/RepoAssets/user-delivery-infomarion_zr1eyv.gif" width="200"/>
            </td>
            <td style="text-align: center">
                <img src="https://res.cloudinary.com/dhyttttax/image/upload/v1695746530/RepoAssets/user-auth-screens_k3h6fw.gif" width="200"/>
            </td>
            <td style="text-align: center">
                <img src="https://res.cloudinary.com/dhyttttax/image/upload/v1695747060/RepoAssets/user-sign-in-loading_qjqmt0.gif" width="200"/>
            </td>
        </tr>
    </table>
</div>

## Contributing:

We welcome contributions from the Flutter community to make this project even better. Whether you are interested in adding new features, fixing bugs, or improving documentation, your contributions are highly appreciated. Please refer to the contribution guidelines in the repository for more details on how to get involved.

<!-- GETTING STARTED -->
## Getting Started

To get started with this project, follow the instructions in the README to set up your development environment and run the app locally. You can also explore the project's architecture, tests, and documentation to gain insights into building robust Flutter apps.

We hope this Flutter-TDD-Clean-Architecture-E-Commerce-App serves as a valuable resource for both Flutter enthusiasts and developers looking to learn about TDD, clean architecture, and BLoC in the context of mobile app development. Happy coding!

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/Sameera-Perera/Flutter-TDD-Clean-Architecture-E-Commerce-App.git
   ```
2. Install packages
   ```sh
   flutter pub get
   ```
3. Run app
   ```sh
   flutter run lib/main.dart
   ```
4. Run test
   ```sh
   flutter test
   ```
For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Sameera-Perera/Flutter-TDD-Clean-Architecture-E-Commerce-App.svg?style=for-the-badge
[contributors-url]: https://github.com/Sameera-Perera/Flutter-TDD-Clean-Architecture-E-Commerce-App/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Sameera-Perera/Flutter-TDD-Clean-Architecture-E-Commerce-App.svg?style=for-the-badge
[forks-url]: https://github.com/Sameera-Perera/Flutter-TDD-Clean-Architecture-E-Commerce-App/network/members
[stars-shield]: https://img.shields.io/github/stars/Sameera-Perera/Flutter-TDD-Clean-Architecture-E-Commerce-App.svg?style=for-the-badge
[stars-url]: https://github.com/Sameera-Perera/Flutter-TDD-Clean-Architecture-E-Commerce-App/stargazers
[issues-shield]: https://img.shields.io/github/issues/Sameera-Perera/Flutter-TDD-Clean-Architecture-E-Commerce-App.svg?style=for-the-badge
[issues-url]: https://github.com/Sameera-Perera/Flutter-TDD-Clean-Architecture-E-Commerce-App/issues
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: http://www.linkedin.com/in/sameera-perera-1148081b8
[product-screenshot]: readme_assets/splash.jpg